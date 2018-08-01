//
//  BaseTableViewCellProtocol.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 8/1/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

protocol BaseTableViewCellProtocol {
    static func cellIdentifier() -> String
    static func cellNibName() -> String
    static func cellHeight() -> CGFloat
    
    associatedtype CellConfigurationType
    func configureCell(withData data: CellConfigurationType, atIndexPath indexPath: NSIndexPath)
}
