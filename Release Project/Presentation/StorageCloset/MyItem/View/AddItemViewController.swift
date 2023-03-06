

import UIKit
import RealmSwift
import PanModal



final class AddItemViewController: BaseViewController {
    
    private let mainView = AddItemView()
    
    private let repository = StyleRepository.shared
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var categoryTasks: Results<Category>!
    
    var seasonTasks: Results<Season>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRealm()
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainView.collectionView.reloadData()
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        repository.initCategoryTagIsSelected(item: categoryTasks)
        repository.initSeasonTagIsSelected(item: seasonTasks)
        self.tabBarController?.tabBar.isHidden = false
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
    
    @objc private func addButtonTapped() {
        let vc = AddItemDetailViewController()
        vc.dataSendClosure = { data in
            self.clothItemTasks = data
        }
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.backButtonTitle = ""
        transition(vc, transitionStyle: .push)
    }
    
    @objc private func listButtonTapped() {
        let vc = AddItemPanModalVC()
        vc.categoryTasks = categoryTasks
        vc.dataSendClosure = { data in
            self.clothItemTasks = data
        }
        presentPanModal(vc)
    }
    
    private func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self).sorted(byKeyPath: "regDate", ascending: false)
        categoryTasks = repository.fetch(Category.self)
        seasonTasks = repository.fetch(Season.self)
        print(#function)
    }
    
}

extension AddItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainView.emptyViewLabel.isHidden = clothItemTasks.count != 0 ? true : false
        return clothItemTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCollectionViewCell.reuseIdentifier, for: indexPath) as? AddItemCollectionViewCell else { return UICollectionViewCell()}
        
        let task = clothItemTasks[indexPath.item]
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SecondHomeDetailViewController()
        // 데이터 넘겨줘야함.
        vc.datatask = clothItemTasks[indexPath.row]
        vc.viewStatus = .edit
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.backButtonTitle = ""
        transition(vc, transitionStyle: .push)
    }
    
}





