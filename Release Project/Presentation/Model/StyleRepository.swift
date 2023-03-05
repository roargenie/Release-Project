

import Foundation
import RealmSwift


protocol StyleRepositoryType {
    
    func fetch<T: Object>(_ table: T.Type) -> Results<T>
    func fetchDateFilter(date: Date) -> Results<Style>
    func fetchDateBeforeWeekFilter<T: Object>(_ item: T.Type) -> Results<T>
    func fetchregDateFilter(itme: ClothItem) -> Results<ClothItem>
    func isSelectedTrueArr<T: Object>(_ table: T.Type) -> Results<T>
    func clothItemCategoryFilter(query: String) -> Results<ClothItem>
    func clothItemOfStyleSeasonFilter() -> Results<Style>
    func styleContainsClothItemFilter(item: ClothItem) -> Results<Style>
    func spingAndAutumnItemFilter() -> Results<ClothItem>
    func summerStyleFilter() -> Results<Style>
    func winterStyleFilter() -> Results<Style>
    func addItem<T: Object>(item: [T])
    func addItemAndplusCount(style: Style, clothItem: ClothItem)
    func isSelectedTrue() -> Results<ClothItem>
    func categoryTagisSelected(item: Category)
    func seasonTagisSelected(item: Season)
    func clothItemisSelected(item: ClothItem)
    func addCategoryToClothItem(item: Results<Category>) -> List<Category>
    func addSeasonToClothItem(item: Results<Season>) -> List<Season>
    func addClothItemToStyle(item: Results<ClothItem>) -> List<ClothItem>
    func addSeasonToStyle(item: Results<Season>) -> List<Season>
    func updateStyle(item: Style, contents: String)
    func deleteClothItem(item: ClothItem)
    func deleteStyleItem(item: Style)
    func initCategoryTagIsSelected(item: Results<Category>)
    func initSeasonTagIsSelected(item: Results<Season>)
    func initClothItemIsSelected(item: Results<ClothItem>)
}

final class StyleRepository: StyleRepositoryType {
    
    let localRealm = try! Realm()
    
    func fetch<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self)
    }
    
    func fetchDateFilter(date: Date) -> Results<Style> {
        return localRealm.objects(Style.self).sorted(byKeyPath: "regDate", ascending: false).filter("regDate >= %@ AND regDate < %@", date, Date(timeInterval: 86400, since: date))
    }
    
    func fetchDateBeforeWeekFilter<T: Object>(_ item: T.Type) -> Results<T> {
        return localRealm.objects(T.self).sorted(byKeyPath: "regDate", ascending: false).filter("regDate >= %@ AND regDate < %@", Date(timeInterval: -604800, since: Date()), Date())
    }
    
    func fetchregDateFilter(itme: ClothItem) -> Results<ClothItem> {
        return localRealm.objects(ClothItem.self)
    }
    
    func isSelectedTrueArr<T: Object>(_ table: T.Type) -> Results<T> {
        return localRealm.objects(table.self).filter("isSelected == true")
    }
    
    func clothItemCategoryFilter(query: String) -> Results<ClothItem> {
        let task = localRealm.objects(ClothItem.self).sorted(byKeyPath: "regDate", ascending: false)
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
    
    func updateStyle(item: Style, contents: String) {
        do {
            try localRealm.write {
                item.contents = contents
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteClothItem(item: ClothItem) {
        
        FileManagerHelper.shared.removeImageFromDocument(fileName: "\(item.objectId).jpg")
        
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteStyleItem(item: Style) {
        
        FileManagerHelper.shared.removeImageFromDocument(fileName: "\(item.objectId).jpg")
        
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
