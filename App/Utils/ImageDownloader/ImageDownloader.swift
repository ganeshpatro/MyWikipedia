//
//  ImageDownloader.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 8/1/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

typealias ImageDownloadedCompletionBlock = (_ image: UIImage?) -> Void

class ImageDownloader: NSObject {

    private static let shared = ImageDownloader()
    
    private var imageDownloadQueue = OperationQueue()
    
    static func SharedDownloader() -> ImageDownloader {
        return shared
    }
    
    override init() {
        imageDownloadQueue.maxConcurrentOperationCount = 1
    }
    
    func downloadImage(withSourceURL sourceURLString: String, withCompletionBlock completionBlock: @escaping (UIImage?) -> Void ) {
        
        guard let validUrl = URL.init(string: sourceURLString) else {
            completionBlock(nil)
            return
        }
        
        let imageDownloadOperation = ImageDownloadOperation(withURL: validUrl) { (downloadedImage) in
            completionBlock(downloadedImage)
        }
        imageDownloadQueue.addOperation(imageDownloadOperation)
    }
}

class ImageDownloadOperation: Operation {
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    enum State: String {
        case ready = "Ready"
        case executing = "Executing"
        case finished = "Finished"
        fileprivate var keyPath: String { return "is" + self.rawValue }
    }
    
    private var callback: ImageDownloadedCompletionBlock!
    private var url: URL!
    
    init(withURL url: URL, withWithCompltionBlock completionBlock: @escaping ImageDownloadedCompletionBlock) {
        self.callback = completionBlock
        self.url = url
    }
    
    override func start() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .ready
            guard let data = try? Data.init(contentsOf: self.url) else {
                callback(nil)
                state = .finished
                return
            }
            
            guard let image = UIImage(data: data) else {
                callback(nil)
                state = .finished
                return
            }
            
            state = .finished
            callback(image)
        }
        
    }
}
