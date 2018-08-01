//
//  WikiDataCell.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 8/1/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

class WikiDataCell: UITableViewCell {
    //MARK:- IBOutlets
    @IBOutlet weak var imgViewWiki: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

//MARK:- BaseCellProtocol Methods
extension WikiDataCell: BaseTableViewCellProtocol {        
    typealias CellConfigurationType = WikiData
    
    static func cellNibName() -> String {
        return "WikiDataCell"
    }
    
    static func cellIdentifier() -> String {
        return "WikiDataCell"
    }
    
    static func cellHeight() -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func configureCell(withData data: WikiDataCell.CellConfigurationType, atIndexPath indexPath: NSIndexPath) {
        
        imgViewWiki?.image = nil
        //Show image
        if let imageSource = data.thumbanil {
            activityIndicator.startAnimating()
            ImageRepository.sharedRepository().getImge(imageSource: imageSource) { [weak self] (image, url) in
                DispatchQueue.main.async {
                    if(url == imageSource) {
                        self?.imgViewWiki.image = image
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        }
        
        //Title
        lblTitle.text = data.title
        
        //Description
        lblDescription.text = data.Desription ?? "NA"
    }
}

