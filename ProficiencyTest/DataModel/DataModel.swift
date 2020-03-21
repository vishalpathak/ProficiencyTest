//
//  DataModel.swift
//  ProficiencyTest
//
//  Created by VishalP India on 21/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation
//Data Model for JSON Response
struct DataInfo: Decodable {
    
    let title: String?
    let rows: [RowInfo]

    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }
}

struct RowInfo: Decodable {
    let title: String?
    let description: String?
    let imageHref: String?
    
    private enum CodingKeys: String, CodingKey{
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
}
