//
//  WikiDataParser.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 7/31/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

class WikiDataParser: NSObject {

    class func parseWikiDataResults(_ results: [String: Any]) -> [WikiData] {
        var arrWikiData = [WikiData]()
        if let queryDict = results["query"] as? [String :Any] {
            let pagesArray = queryDict["pages"] as! [[String :Any]]
            for pageDict in pagesArray {
                let title = pageDict["title"] as! String
                
                var description: String?
                if let terms = pageDict["terms"] as? [String: Any],
                    let descriptionArray = terms["description"] as? [String] {
                    description = descriptionArray[0]
                }
                
                var imageSource: String?
                if let thumbanil = pageDict["thumbnail"] as? [String: Any] {
                    imageSource = thumbanil["source"] as? String
                }
                
                let pageId = String.init(pageDict["pageid"] as! Int)
                let wikiData = WikiData(title: title, Desription: description, thumbanil: imageSource, pageId: pageId)
                arrWikiData.append(wikiData)
            }
        }        
        return arrWikiData
    }
}
