//
//  ViewModel.swift
//  ProficiencyTest
//
//  Created by VishalP on 21/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import Foundation

struct DataInfoViewModel {
    let title: String
    let description: String
    let imageInfo: String
    
    //Dependency Injection DI
    init(dataInfo: RowInfo) {
        self.title = dataInfo.title ?? DefaultString.DefaultTitle
        self.description = dataInfo.description ?? DefaultString.DefaultDescription
        self.imageInfo = dataInfo.imageHref ?? ""
    }
}
