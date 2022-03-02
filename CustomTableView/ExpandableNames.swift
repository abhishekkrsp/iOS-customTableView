//
//  ExpandableNames.swift
//  CustomTableView
//
//  Created by Abhishek Kumar on 02/03/22.
//

import Foundation

struct ContactName {
    var name: String
    var isFavorite = false
}

struct ExpandableNames {
    var isExpanded = false
    var names: [ContactName]
}

