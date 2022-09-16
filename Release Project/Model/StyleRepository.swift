

import Foundation
import RealmSwift


protocol StyleRepositoryType {
    
}

final class StyleRepository {
    
    let localRealm = try! Realm()
    
    func fetch<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self).sorted(byKeyPath: "objectId", ascending: true)
    }
    
//    func filterTag<T: Object>(title: String) -> Results<T> {
//        return localRealm.objects(T.self).filter("title CONTAINS[c] '\(title)'")
//    }
    
    func filterTag<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self)
    }
    
//    func categoryTagisSelectedTrueArr() -> Results<Category> {
//        return localRealm.objects(Category.self).filter("isSelected == true")
//    }
//
//    func seasonTagisSelectedTrueArr() -> Results<Season> {
//        return localRealm.objects(Season.self).filter("isSelected == true")
//    }
    
    func isSelectedTrueArr<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self).filter("isSelected == true")
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
    
//    func initCategoryTagIsSelected(item: Category) {
//        do {
//            try localRealm.write {
//                item.setValue(false, forKey: "isSelected")
//            }
//        } catch {
//            print("error")
//        }
//    }
    func initCategoryTagIsSelected(item: Results<Category>) {
        do {
            try localRealm.write {
                for i in item {
                    i.isSelected = false
                }
            }
        } catch {
            print("error")
        }
    }
    
    func initSeasonTagIsSelected(item: Results<Season>) {
        do {
            try localRealm.write {
                for i in item {
                    i.isSelected = false
                }
            }
        } catch {
            print("error")
        }
    }
    
    
}
