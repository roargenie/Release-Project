

import Foundation
import RealmSwift


final class Category: Object {

    @Persisted var title: String
    @Persisted var isSelected: Bool

    @Persisted(primaryKey: true) var objectId: ObjectId

    convenience init(title: String) {
        self.init()
        self.title = title
        self.isSelected = false
    }

}

final class Season: Object {
    
    @Persisted var title: String
    @Persisted var isSelected: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.isSelected = false
    }
}

final class ClothItem: Object {
    
    @Persisted var itemName: String?
    @Persisted var wornCount: Int = 0
    @Persisted var regDate = Date()
    @Persisted var favorite: Bool
    
    @Persisted var category: Category?
    @Persisted var season: List<Season>
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(itemName: String?, regDate: Date, category: Category, season: List<Season>) {
        self.init()
        self.itemName = itemName
        self.wornCount = 0
        self.regDate = regDate
        self.category = category
        self.season = season
        self.favorite = false
    }
    
}

final class Style: Object {
    
    @Persisted var contents: String?
    @Persisted var regDate = Date()
    
    @Persisted var clothItem: List<ClothItem>
    @Persisted var season: List<Season>
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(contents: String?, regDate: Date, clothItem: List<ClothItem>, season: List<Season>) {
        self.init()
        self.contents = contents
        self.regDate = regDate
        self.clothItem = clothItem
        self.season = season
    }
    
}


