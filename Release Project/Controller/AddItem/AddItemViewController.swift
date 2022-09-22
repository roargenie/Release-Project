

import UIKit
import RealmSwift
import PanModal



final class AddItemViewController: BaseViewController {
    
    var mainView = AddItemView()
    
    private let repository = StyleRepository()
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var categoryTasks: Results<Category>!
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRealm()
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        mainView.collectionView.reloadData()
        print(#function)
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
        vc.dataSendClosure = { data in
            self.clothItemTasks = data
        }
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
    @objc func listButtonTapped() {
        let vc = AddItemPanModalVC()
        vc.categoryTasks = categoryTasks
        vc.dataSendClosure = { data in
            self.clothItemTasks = data
        }
        presentPanModal(vc)
    }
    
    private func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self)
        categoryTasks = repository.fetch(Category.self)
        print(#function)
    }
    
}

extension AddItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothItemTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCollectionViewCell.reuseIdentifier, for: indexPath) as? AddItemCollectionViewCell else { return UICollectionViewCell()}
        let task = clothItemTasks[indexPath.item]
        
        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SecondHomeDetailViewController()
        // 데이터 넘겨줘야함.
        
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
}





