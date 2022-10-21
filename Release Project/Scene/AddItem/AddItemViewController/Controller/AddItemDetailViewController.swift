

import UIKit
import RealmSwift
import YPImagePicker


final class AddItemDetailViewController: BaseViewController {
    
    // MARK: - 열거형 사용해보기
    private enum TagSection: Int {
        case category = 0, season
    }
    
    private let mainView = AddItemDetailView()
    
    private let repository = StyleRepository()
    
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
    
    var dataSendClosure: ((Results<ClothItem>) -> Void)?
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "아이템 추가"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        dataSendClosure?(repository.fetch(ClothItem.self).sorted(byKeyPath: "regDate", ascending: false))
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(cameraButtonTapped))
        self.navigationItem.rightBarButtonItems = [saveButton, cameraButton]
    }
    
    @objc private func saveButtonTapped() {
        let categoryTagData = repository.addCategoryToClothItem(item: repository.isSelectedTrueArr(Category.self))
        let seasonTagData = repository.addSeasonToClothItem(item: repository.isSelectedTrueArr(Season.self))
        if mainView.imageView.image != nil {
            if !categoryTagData.isEmpty && !seasonTagData.isEmpty {
                let savedItem = ClothItem(itemName: "", regDate: Date(), category: categoryTagData, season: seasonTagData)
                repository.addItem(item: [savedItem])
                if let image = mainView.imageView.image {
                    FileManagerHelper.shared.saveImageToDocument(fileName: "\(savedItem.objectId).jpg", image: image)
                }
                self.navigationController?.popViewController(animated: true)
                
            } else if categoryTagData.isEmpty && !seasonTagData.isEmpty {
                showAlertMessageNoHandler(title: "카테고리를 선택해주세요!", button: "확인")
            } else if seasonTagData.isEmpty && !categoryTagData.isEmpty {
                showAlertMessageNoHandler(title: "계절을 선택해주세요!", button: "확인")
            } else if categoryTagData.isEmpty && seasonTagData.isEmpty {
                showAlertMessageNoHandler(title: "태그를 선택해주세요!", button: "확인")
            }
        } else {
            showAlertMessageNoHandler(title: "이미지를 선택해주세요!", button: "확인")
        }
    }
    
    @objc private func cameraButtonTapped() {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.mainView.imageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    private func fetchRealm() {
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
