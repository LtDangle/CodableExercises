//
//  usableInfoProtocol.swift
//  CodableExercises
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

protocol SubCellInfo {
    var textLabelText: String {get}
    var detailTextLabelText: String {get}
    var imagePath: String? {get}
}
