

import UIKit
import RealmSwift
import YPImagePicker


final class DiaryDetailViewController: BaseViewController {
    
    var mainView = FirstDiaryDetailView()
    
    fileprivate let repository = StyleRepository()
    
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
        repository.initSeasonTagIsSelected(item: seasonTasks)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        repository.initClothItemIsSelected(item: clothItemTasks)
        repository.initSeasonTagIsSelected(item: seasonTasks)
        fetchRealm()
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        //mainView.collectionView.isMultipleTouchEnabled = false
        mainView.seasonCollectionView.delegate = self
        mainView.seasonCollectionView.dataSource = self
        mainView.categoryTabbarCollectionView.delegate = self
        mainView.categoryTabbarCollectionView.dataSource = self
        mainView.addImageButton.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItems = [saveButton]
    }
    
    func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self)
        styleTasks = repository.fetch(Style.self)
        seasonTasks = repository.fetch(Season.self)
        categoryTasks = repository.fetch(Category.self)
    }
    
    @objc func addImageButtonTapped() {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
//                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.
//
                self.mainView.imageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        guard let text = mainView.textView.text else { return print("값이 없음") }
        let clothItemData = repository.addClothItemToStyle(item: repository.isSelectedTrueArr(ClothItem.self))
        let seasonTagData = repository.addSeasonToClothItem(item: repository.isSelectedTrueArr(Season.self))
        
        let savedItem = Style(contents: text, regDate: Date(), clothItem: clothItemData, season: seasonTagData)
        
        repository.addItem(item: [savedItem])
        
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
            
            cell.imageView.backgroundColor = .darkGray
            
            let task = clothItemTasks[indexPath.item]
            
            let borderColor = task.isSelected ? UIColor.systemRed.cgColor : nil
            let borderWidth: CGFloat = task.isSelected ? 2 : 0
            
            cell.layer.borderWidth = borderWidth
            cell.layer.borderColor = borderColor
            
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
            
            cell.backgroundColor = .secondarySystemBackground
            cell.categoryTagLabel.text = task.title
            
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
                print("0")
                print(clothItemTasks)
                fetchRealm()
            case 1:
                clothItemTasks = repository.clothItemCategoryFilter(query: "상의")
                print("1")
                print(clothItemTasks)
                fetchRealm()
            case 2:
                clothItemTasks = repository.clothItemCategoryFilter(query: "하의")
                print(clothItemTasks)
                fetchRealm()
            case 3:
                clothItemTasks = repository.clothItemCategoryFilter(query: "신발")
                print(clothItemTasks)
                fetchRealm()
            case 4:
                clothItemTasks = repository.clothItemCategoryFilter(query: "악세")
                print(clothItemTasks)
                fetchRealm()
            case 5:
                clothItemTasks = repository.clothItemCategoryFilter(query: "기타")
                print(clothItemTasks)
                fetchRealm()
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
