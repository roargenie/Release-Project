

import UIKit
import RealmSwift
import YPImagePicker


final class DiaryDetailViewController: BaseViewController {
    
    private var mainView = FirstDiaryDetailView()
    
    private let repository = StyleRepository()
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.collectionView.reloadData()
            mainView.categoryTabbarCollectionView.reloadData()
            mainView.seasonCollectionView.reloadData()
        }
    }
    
    var styleTasks: Results<Style>! {
        didSet {
            mainView.collectionView.reloadData()
            mainView.seasonCollectionView.reloadData()
        }
    }
    
    var categoryTasks: Results<Category>! {
        didSet {
            mainView.collectionView.reloadData()
            mainView.categoryTabbarCollectionView.reloadData()
        }
    }
    
    var seasonTasks: Results<Season>! {
        didSet {
            mainView.collectionView.reloadData()
            mainView.seasonCollectionView.reloadData()
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
        repository.initClothItemIsSelected(item: clothItemTasks)
        repository.initCategoryTagIsSelected(item: categoryTasks)
        repository.initSeasonTagIsSelected(item: seasonTasks)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        repository.initClothItemIsSelected(item: clothItemTasks)
        repository.initCategoryTagIsSelected(item: categoryTasks)
        repository.initSeasonTagIsSelected(item: seasonTasks)
        fetchRealm()
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.seasonCollectionView.delegate = self
        mainView.seasonCollectionView.dataSource = self
        mainView.categoryTabbarCollectionView.delegate = self
        mainView.categoryTabbarCollectionView.dataSource = self
        //hideKeyboard()
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        let cameraButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(cameraButtonTapped))
        self.navigationItem.rightBarButtonItems = [saveButton, cameraButton]
    }
    
    private func fetchRealm() {
        //clothItemTasks = repository.testFetch(ClothItem.self) // 아이템 선택시도 페치되고 있음. 이걸 어떻게 처리할건데??????????????? 페치를 안하면 되지않나???????????
        styleTasks = repository.fetch(Style.self)
        seasonTasks = repository.fetch(Season.self)
        categoryTasks = repository.fetch(Category.self)
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
    
    @objc private func saveButtonTapped() {
        guard let text = mainView.textView.text else { return print("값이 없음") }
        // 텍스트 없을때 예외처리 해줘야됨
        
        let clothItemData = repository.addClothItemToStyle(item: repository.isSelectedTrueArr(ClothItem.self))
        let seasonTagData = repository.addSeasonToClothItem(item: repository.isSelectedTrueArr(Season.self))
        
        let savedItem = Style(contents: text, regDate: Date(), clothItem: clothItemData, season: seasonTagData)
        
        repository.isSelectedTrueArr(ClothItem.self).forEach {
            repository.addItemAndplusCount(style: savedItem, clothItem: $0)
        }
        if let image = mainView.imageView.image {
            FileManagerHelper.shared.saveImageToDocument(fileName: "\(savedItem.objectId).jpg", image: image)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension DiaryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.collectionView {
            return clothItemTasks.count
        } else if collectionView == mainView.seasonCollectionView {
            return seasonTasks.count
        } else {
            return categoryTasks.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == mainView.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
            
            let task = clothItemTasks[indexPath.item]
            
            let borderColor = task.isSelected ? UIColor.systemRed.cgColor : nil
            let borderWidth: CGFloat = task.isSelected ? 2 : 0
            
            cell.layer.borderWidth = borderWidth
            cell.layer.borderColor = borderColor
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
            
            return cell
        } else if collectionView == mainView.seasonCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailSeasonCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailSeasonCollectionViewCell else { return UICollectionViewCell() }
            
            let task = seasonTasks[indexPath.item]
            
            let backGroundColor = task.isSelected ? UIColor.black : UIColor.white
            let titleColor = task.isSelected ? UIColor.white : UIColor.darkGray
            let borderColor = task.isSelected ? UIColor.white.cgColor : UIColor.darkGray.cgColor
            
            cell.seasonTagLabel.text = task.title
            
            cell.seasonTagLabel.textColor = titleColor
            cell.layer.borderColor = borderColor
            cell.backgroundColor = backGroundColor
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTabbarCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailTabbarCollectionViewCell else { return UICollectionViewCell() }
            
            let task = categoryTasks[indexPath.item]
            
            let backGroundColor = task.isSelected ? UIColor.black : UIColor.white
            let titleColor = task.isSelected ? UIColor.white : UIColor.darkGray
            
            cell.categoryTagLabel.text = task.title
            cell.categoryTagLabel.textColor = titleColor
            cell.backgroundColor = backGroundColor
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == mainView.collectionView {
            let task = clothItemTasks[indexPath.item]
            repository.clothItemisSelected(item: task)
            fetchRealm()
        } else if collectionView == mainView.seasonCollectionView {
            let task = seasonTasks[indexPath.item]
            
            repository.seasonTagisSelected(item: task)
            fetchRealm()
            print(#function, indexPath.item)
        } else {
            
            switch indexPath.item {
            case 0:
                clothItemTasks = repository.clothItemCategoryFilter(query: "아우터")
                repository.initCategoryTagIsSelected(item: categoryTasks)
                repository.categoryTagisSelected(item: categoryTasks[indexPath.item])
                mainView.collectionView.reloadData()
                return
            case 1:
                clothItemTasks = repository.clothItemCategoryFilter(query: "상의")
                repository.initCategoryTagIsSelected(item: categoryTasks)
                repository.categoryTagisSelected(item: categoryTasks[indexPath.item])
                mainView.collectionView.reloadData()
                return
            case 2:
                clothItemTasks = repository.clothItemCategoryFilter(query: "하의")
                repository.initCategoryTagIsSelected(item: categoryTasks)
                repository.categoryTagisSelected(item: categoryTasks[indexPath.item])
                mainView.collectionView.reloadData()
                return
            case 3:
                clothItemTasks = repository.clothItemCategoryFilter(query: "신발")
                repository.initCategoryTagIsSelected(item: categoryTasks)
                repository.categoryTagisSelected(item: categoryTasks[indexPath.item])
                mainView.collectionView.reloadData()
                return
            case 4:
                clothItemTasks = repository.clothItemCategoryFilter(query: "악세")
                repository.initCategoryTagIsSelected(item: categoryTasks)
                repository.categoryTagisSelected(item: categoryTasks[indexPath.item])
                mainView.collectionView.reloadData()
                return
            case 5:
                clothItemTasks = repository.clothItemCategoryFilter(query: "기타")
                repository.initCategoryTagIsSelected(item: categoryTasks)
                repository.categoryTagisSelected(item: categoryTasks[indexPath.item])
                mainView.collectionView.reloadData()
                return
            default:
                break
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if collectionView == mainView.seasonCollectionView {
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FirstAddItemDetailCollectionReusableView.identifier, for: indexPath) as! FirstAddItemDetailCollectionReusableView
                
                headerView.headerLabel.text = "계절"
                
                return headerView
            default:
                #if DEBUG
                assert(false)
                #else
                return UICollectionReusableView()
                #endif
            }
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    
}
