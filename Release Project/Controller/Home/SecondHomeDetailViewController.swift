

import UIKit
import RealmSwift


final class SecondHomeDetailViewController: BaseViewController {
    
    var mainView = SecondHomeDetailView()
    
    fileprivate let repository = StyleRepository()
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var styleTasks: Results<Style>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var datatask = ClothItem()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        
    }
    
    func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self)
        styleTasks = repository.styleContainsClothItemFilter(item: datatask)
        
    }
    
}


extension SecondHomeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styleTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let task = styleTasks[indexPath.item]
        
        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeDetailCollectionReusableView.identifier, for: indexPath) as! HomeDetailCollectionReusableView
            
            let task = datatask
            var seasonArr: [String] = []
            for i in task.season {
                seasonArr.append(i.title)
            }
            let seasonStr = seasonArr.joined(separator: ", ")
            
            headerView.categoryContentLabel.text = task.category.first?.title
            headerView.seasonContentLabel.text = seasonStr
            headerView.wornCountContentLabel.text = String(task.wornCount)
            headerView.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(datatask.objectId).jpg")
            
            return headerView
        default:
        #if DEBUG
            assert(false)
        #else
            return UICollectionReusableView()
        #endif
        }
    }
}
