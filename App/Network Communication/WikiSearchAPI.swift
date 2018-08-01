//
//  WikiSearchAPI.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 7/31/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

enum WikiDataResult<T> {
    case success([T])
    case error(Error)
}

enum WikiSearchAPIURL: String {
    case BASE = "https://en.wikipedia.org//w/api.php?"
}

struct WikiSearchAPI {
    typealias WikiDataResultCallback = (_ result: WikiDataResult<WikiData>) -> Void
    
    static func searchWikiData(withSearchString searchString: String, withResultCallback callback: @escaping WikiDataResultCallback) {
        let parameters = "action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description"
        let searchUrlString = WikiSearchAPIURL.BASE.rawValue + parameters + "&gpssearch=" + searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&gpslimit=20"
        NetworkRequestManager.sharedManager.sendGETRequest(searchUrlString) { (result) in
            switch(result) {
            case .success(let responseData):
                //Parse the response
                print("Response is - \(String(describing: String.init(data: responseData, encoding: String.Encoding.utf8)))")
                do {
                    let searchResultDict = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments);
                callback(WikiDataResult<WikiData>.success(WikiDataParser.parseWikiDataResults(searchResultDict as! [String : Any])))
                } catch(let error) {
                    print("Error in serializing - \(error)")
                    callback(WikiDataResult<WikiData>.error(error))
                }
            case .failue(let error):
                print(error)
                callback(WikiDataResult<WikiData>.error(error))
            }
        }
    }
}
