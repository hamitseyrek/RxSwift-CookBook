//
//  SectionModel.swift
//  RxSwift CookBook
//
//  Created by Hamit Seyrek on 17.04.2022.
//

import Foundation
import RxDataSources

struct SectionModel {
     
    var header : String
    var items : [Food]
}

extension SectionModel: SectionModelType {
    
    init(original: SectionModel, items: [Food]) {
        self = original
        self.items = items
    }
}
