

import Foundation
import RealmSwift


protocol StyleRepositoryType {
    
}

final class StyleRepository {
    
    let localRealm = try! Realm()
    
    func fetch<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self).sorted(byKeyPath: "objectId", ascending: true)
    }
    
    func filterTag<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self)
    }
    
    func fetchDateFilter(date: Date) -> Results<Style> {
        return localRealm.objects(Style.self).filter("regDate >= %@ AND regDate < %@", date, Date(timeInterval: 86400, since: date))
    }
    
    func fetchDateBeforeWeekFilter(date: Date) -> Results<ClothItem> {
        return localRealm.objects(ClothItem.self).filter("regDate >= %@ AND regDate < %@", date, Date(timeInterval: 604800, since: date))
    }
    
    func fetchregDateFilter(itme: ClothItem) -> Results<ClothItem> {
        return localRealm.objects(ClothItem.self)
    }
    
    func isSelectedTrueArr<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self).filter("isSelected == true")
    }
    
    func clothItemCategoryFilter(query: String) -> Results<ClothItem> {
        let task = localRealm.objects(ClothItem.self)
        let filterdData = task.where {
            $0.category.title == "\(query)"
        }
        return filterdData
    }
    
    func clothItemOfStyleSeasonFilter() -> Results<Style> {
        let task = localRealm.objects(Style.self)
        let filterData = task.where {
            $0.clothItem.season.isSelected == true
        }
        return filterData
    }
    
    func styleContainsClothItemFilter(item: ClothItem) -> Results<Style> {
        let task = localRealm.objects(Style.self)
        
        let filterdData = task.where {
            $0.clothItem.objectId == item.objectId
        }
        return filterdData
    }
    
    func spingAndAutumnItemFilter() -> Results<ClothItem> {
        let task = localRealm.objects(ClothItem.self)
        
        let filterdData = task.where {
            $0.season.title == "봄" || $0.season.title == "가을"
        }
        return filterdData
    }
    
    func summerItemFilter() -> Results<ClothItem> {
        let task = localRealm.objects(ClothItem.self)
        
        let filterdData = task.where {
            $0.season.title == "여름"
        }
        return filterdData
    }
    
    func winterItemFilter() -> Results<ClothItem> {
        let task = localRealm.objects(ClothItem.self)
        
        let filterdData = task.where {
            $0.season.title == "겨울"
        }
        return filterdData
    }
    
    func springAndAutumnStyleFilter() -> Results<Style> {
        let task = localRealm.objects(Style.self)
        
        let filterdData = task.where {
            $0.season.title == "봄" || $0.season.title == "가을"
        }
        return filterdData
    }
    
    func summerStyleFilter() -> Results<Style> {
        let task = localRealm.objects(Style.self)
        
        let filterdData = task.where {
            $0.season.title == "여름"
        }
        return filterdData
    }
    
    func winterStyleFilter() -> Results<Style> {
        let task = localRealm.objects(Style.self)
        
        let filterdData = task.where {
            $0.season.title == "겨울"
        }
        return filterdData
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
    
    func isSelectedTrue() -> Results<ClothItem> {
        let task = localRealm.objects(ClothItem.self)
        
        let filtered = task.where {
            $0.isSelected == true
        }
        return filtered
    }
    
    func addItemAndplusCount(style: Style, clothItem: ClothItem) {
        do {
            try localRealm.write {
                localRealm.add(style)
                if clothItem.isSelected == true {
                    clothItem.wornCount += 1
                }
            }
        } catch {
            print("error")
        }
    }
    
    func categoryTagisSelected(item: Category) {
        do {
            try localRealm.write {
                item.isSelected = !item.isSelected
            }
        } catch {
            print("error")
        }
    }
    
    func seasonTagisSelected(item: Season) {
        do {
            try localRealm.write {
                item.isSelected = !item.isSelected
            }
        } catch {
            print("error")
        }
    }
    
    func clothItemisSelected(item: ClothItem) {
        do {
            try localRealm.write {
                item.isSelected = !item.isSelected
            }
        } catch {
            print("error")
        }
    }
    
    func addCategoryToClothItem(item: Results<Category>) -> List<Category> {
        let task = ClothItem()
        
        do {
            try localRealm.write { () -> List<Category> in
                for i in item {
                    task.category.append(i)
                }
                return task.category
            }
        } catch {
            print("error")
        }
        return task.category
    }
    
    func addSeasonToClothItem(item: Results<Season>) -> List<Season> {
        let task = ClothItem()
        
        do {
            try localRealm.write { () -> List<Season> in
                for i in item {
                    task.season.append(i)
                }
                return task.season
            }
        } catch {
            print("error")
        }
        return task.season
    }
    
    func addClothItemToStyle(item: Results<ClothItem>) -> List<ClothItem> {
        let task = Style()
        
        do {
            try localRealm.write { () -> List<ClothItem> in
                for i in item {
                    task.clothItem.append(i)
                }
                return task.clothItem
            }
        } catch {
            print("error")
        }
        return task.clothItem
    }
    
    func addSeasonToStyle(item: Results<Season>) -> List<Season> {
        let task = Style()
        
        do {
            try localRealm.write { () -> List<Season> in
                for i in item {
                    task.season.append(i)
                }
                return task.season
            }
        } catch {
            print("error")
        }
        return task.season
    }
    
    func deleteItem<T: Object>(item: T) {
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
    
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
    
    func initClothItemIsSelected(item: Results<ClothItem>) {
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
