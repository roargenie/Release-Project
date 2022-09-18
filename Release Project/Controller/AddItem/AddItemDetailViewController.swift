

import UIKit
import RealmSwift



final class AddItemDetailViewController: BaseViewController {
    
    // MARK: - 열거형 사용해보기
    enum TagSection: Int {
        case category = 0, season

    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
        repository.initCategoryTagIsSelected(item: categoryTasks)
        repository.initSeasonTagIsSelected(item: seasonTasks)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        repository.initCategoryTagIsSelected(item: categoryTasks)
        repository.initSeasonTagIsSelected(item: seasonTasks)
        fetchRealm()
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
        let categoryTagData = repository.addCategoryToClothItem(item: repository.isSelectedTrueArr(Category.self))
        let seasonTagData = repository.addSeasonToClothItem(item: repository.isSelectedTrueArr(Season.self))
        let savedItem = ClothItem(itemName: "우와", regDate: Date(), category: categoryTagData, season: seasonTagData)
        repository.addItem(item: [savedItem])
        print(categoryTagData)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchRealm() {
        categoryTasks = repository.fetch(Category.self)
        seasonTasks = repository.fetch(Season.self)
    }
    
}


extension AddItemDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return categoryTasks.count
        } else {
            return seasonTasks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondAddItemDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondAddItemDetailCollectionViewCell else { return UICollectionViewCell() }
            
            let task = categoryTasks[indexPath.item]
            
            let backGroundColor = task.isSelected ? UIColor.black : UIColor.white
            let titleColor = task.isSelected ? UIColor.white : UIColor.darkGray
            let borderColor = task.isSelected ? UIColor.white.cgColor : UIColor.darkGray.cgColor
            
            cell.categoryTagLabel.text = task.title
            cell.categoryTagLabel.textColor = titleColor
            cell.backgroundColor = backGroundColor
            cell.layer.borderColor = borderColor
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThirdAddItemDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? ThirdAddItemDetailCollectionViewCell else { return UICollectionViewCell() }
            
            let task = seasonTasks[indexPath.item]
            
            let backGroundColor = task.isSelected ? UIColor.black : UIColor.white
            let titleColor = task.isSelected ? UIColor.white : UIColor.darkGray
            let borderColor = task.isSelected ? UIColor.white.cgColor : UIColor.darkGray.cgColor
            
            cell.seasonTagLabel.text = task.title
            cell.seasonTagLabel.textColor = titleColor
            cell.layer.borderColor = borderColor
            cell.backgroundColor = backGroundColor
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let task = categoryTasks[indexPath.item]
            
            repository.initCategoryTagIsSelected(item: categoryTasks)
            repository.categoryTagisSelected(item: task)
            fetchRealm()
            
            print(#function, indexPath.item)
            print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
        } else {
            let task = seasonTasks[indexPath.item]
            
            repository.seasonTagisSelected(item: task)
            fetchRealm()
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
