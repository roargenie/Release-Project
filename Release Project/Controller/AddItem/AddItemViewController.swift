

import UIKit
import RealmSwift

final class AddItemViewController: BaseViewController {
    
    var mainView = AddItemView()
    
    fileprivate let repository = StyleRepository()
    
    var clothItemTasks: Results<ClothItem>! {
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
        self.tabBarController?.tabBar.isHidden = false
        fetchRealm()
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(listButtonTapped))
        navigationItem.leftBarButtonItems = [listButton]
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    @objc func addButtonTapped() {
        let vc = AddItemDetailViewController()
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
    @objc func listButtonTapped() {
        
    }
    
    fileprivate func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self)
    }
    
}

extension AddItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothItemTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCollectionViewCell.reuseIdentifier, for: indexPath) as? AddItemCollectionViewCell else { return UICollectionViewCell()}
        let task = clothItemTasks[indexPath.item]
        
        cell.imageView.backgroundColor = .systemGray3
        cell.itemLabel.text = task.itemName
        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SecondHomeDetailViewController()
        // 데이터 넘겨줘야함.
        
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddItemCollectionReusableView.identifier, for: indexPath) as! AddItemCollectionReusableView
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





