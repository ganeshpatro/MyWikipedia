//
//  ImageRepository.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 8/1/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

typealias ImageCompletionBlock = (_ image : UIImage, _ url: String) -> Void

class ImageRepository: NSObject {

    private static let shared = ImageRepository()
    private var imageRepoDict:[String: UIImage] = [String: UIImage]()
    
    static func sharedRepository() -> ImageRepository {
        return shared
    }
    
    func getImge(imageSource sourceURL: String, withCompletionBlock completionBlock: @escaping ImageCompletionBlock) {
        if let image = imageRepoDict[sourceURL] {
            print("Image Found for URL - \(sourceURL)")
            completionBlock(image, sourceURL)
        } else {
            print("Image need to be downloaded for URL - \(sourceURL)")
            ImageDownloader.SharedDownloader().downloadImage(withSourceURL: sourceURL) { [weak self] (image) in
                if let downloadedImage = image {
                    self?.imageRepoDict[sourceURL] = downloadedImage
                    completionBlock(downloadedImage, sourceURL)
                }
            }
        }
    }
}
