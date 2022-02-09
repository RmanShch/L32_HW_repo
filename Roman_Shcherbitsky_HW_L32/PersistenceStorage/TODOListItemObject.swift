//
//  TODOListItemObject.swift
//  Roman_Shcherbitsky_HW_L32
//
//  Created by Анна Шербицкая on 9.02.22.
//

import Foundation
import RealmSwift

class TODOListItemObject: Object {
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var lastUpdatedDate: Date
    @Persisted var createdDate: Date
    @Persisted(primaryKey: true) var id: String
    
    convenience init(with item: TODOListItem) {
        self.init()
        self.title = item.title
        self.body = item.body
        self.lastUpdatedDate = item.lastUpdatedDate
        self.createdDate = item.createdDate
        self.id = String(createdDate.timeIntervalSince1970)
    }
    
    var item: TODOListItem {
        TODOListItem(title: title, body: body, lastUpdatedDate: lastUpdatedDate, createdDate: createdDate)
    }
}
