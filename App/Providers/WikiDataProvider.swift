//
//  WikiDataProvider.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 7/31/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

class WikiDataProvider: NSObject {

    private static var shared = WikiDataProvider()
    
    static func sharedProvider() -> WikiDataProvider {
        return shared;
    }
}
