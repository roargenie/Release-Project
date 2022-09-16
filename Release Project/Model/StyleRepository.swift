

import Foundation
import RealmSwift


protocol StyleRepositoryType {
    
}

final class StyleRepository {
    
    let localRealm = try! Realm()
    
    func fetch<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self)
    }
    
//    func filterTag<T: Object>(title: String) -> Results<T> {
//        return localRealm.objects(T.self).filter("title CONTAINS[c] '\(title)'")
//    }
    
    func filterTag<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self)
    }
    
    
    func addItem<T: Object>(item: [T]) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch {
            print("error")
        }
    }
    
    func categoryTagIsSelected(item: Category) {
        do {
            try localRealm.write {
                item.isSelected = !item.isSelected
            }
        } catch {
            print("error")
        }
    }
    
    func seasonTagIsSelected(item: Season) {
        do {
            try localRealm.write {
                item.isSelected = !item.isSelected
            }
        } catch {
            print("error")
        }
    }
    
    func initCategoryTag(item: Category) {
        do {
            try localRealm.write {
                item.isSelected = false
            }
        } catch {
            print("error")
        }
    }
    
    
}
