

import UIKit
import RealmSwift



final class AddItemDetailViewController: BaseViewController {
    
    var mainView = AddItemDetailView()
    
    fileprivate let repository = StyleRepository()
    
    var categoryTasks: Results<Category>! {
        didSet {
            mainView.collectionView.reloadData()
            
        }
    }
    
    var seasonTasks: Results<Season>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //repository.initCategoryTag(item: Category.init())
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItems = [saveButton]
    }
    
    @objc func saveButtonTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchRealm() {
        categoryTasks = repository.filterTag(Category.self).sorted(byKeyPath: "objectId", ascending: true)
        seasonTasks = repository.filterTag(Season.self).sorted(byKeyPath: "objectId", ascending: false)
    }
    
}


extension AddItemDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return repository.filterTag(Category.self).count
        } else {
            return repository.filterTag(Season.self).count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondAddItemDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondAddItemDetailCollectionViewCell else { return UICollectionViewCell() }
            
            let task = repository.filterTag(Category.self)[indexPath.item]
            
            let backGroundColor = task.isSelected ? UIColor.black : UIColor.white
            let titleColor = task.isSelected ? UIColor.white : UIColor.darkGray
            let borderColor = task.isSelected ? UIColor.white.cgColor : UIColor.darkGray.cgColor
            
            cell.categoryTagLabel.text = task.title
            cell.categoryTagLabel.textColor = titleColor
            cell.backgroundColor = backGroundColor
            cell.layer.borderWidth = 2
            cell.layer.borderColor = borderColor
            cell.layer.cornerRadius = 20
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThirdAddItemDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? ThirdAddItemDetailCollectionViewCell else { return UICollectionViewCell() }
            
            let task = repository.filterTag(Season.self)[indexPath.item]
            
            let backGroundColor = task.isSelected ? UIColor.black : UIColor.white
            let titleColor = task.isSelected ? UIColor.white : UIColor.darkGray
            let borderColor = task.isSelected ? UIColor.white.cgColor : UIColor.darkGray.cgColor
            
            cell.seasonTagLabel.text = task.title
            cell.seasonTagLabel.textColor = titleColor
            cell.backgroundColor = backGroundColor
            cell.layer.borderWidth = 2
            cell.layer.borderColor = borderColor
            cell.layer.cornerRadius = 20
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.tag = indexPath.item
            let task = repository.filterTag(Category.self)[indexPath.item]
            repository.categoryTagIsSelected(item: task)
            print(#function, indexPath.item)
            print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
        } else {
            let task = repository.filterTag(Season.self)[indexPath.item]
            repository.seasonTagIsSelected(item: task)
            print(#function, indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let task = repository.filterTag(Category.self)[indexPath.item]
            repository.categoryTagIsSelected(item: task)
            mainView.collectionView.reloadData()
        } else {
            let task = repository.filterTag(Season.self)[indexPath.item]
            repository.seasonTagIsSelected(item: task)
            print(#function, indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FirstAddItemDetailCollectionReusableView.identifier, for: indexPath) as! FirstAddItemDetailCollectionReusableView
            if indexPath.section == 0 {
                headerView.headerLabel.text = "카테고리"
                return headerView
            } else {
                headerView.headerLabel.text = "계절"
                return headerView
            }
            
        default:
            #if DEBUG
            assert(false)
            #else
            return UICollectionReusableView()
            #endif
        }
        
    }
    
}
