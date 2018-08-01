//
//  Extensions.swift
//  MyWikipedia
//
//  Created by Ganesh Patro on 8/1/18.
//  Copyright © 2018 Ganesh Patro. All rights reserved.
//

import UIKit

//MARK:- UITableView
extension UITableView {
    func registerNib(withNibName nibName: String, withCellIdentifier identifier: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func configureForSelfSizingCell(withEstimatedHeight estimatedHeight: CGFloat) {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = estimatedHeight
    }
}
