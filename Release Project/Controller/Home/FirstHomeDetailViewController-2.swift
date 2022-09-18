

import UIKit
import RealmSwift


final class FirstHomeDetailViewController2: BaseViewController {
    
    var mainView = FirstHomeDetailView1()
    
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
        super.viewWillAppear(animated)
        fetchRealm()
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
    }
    
}

extension FirstHomeDetailViewController2: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothItemTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? FirstHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let task = clothItemTasks[indexPath.item]
        
        cell.imageView.backgroundColor = .systemMint
        cell.itemLabel.text = task.itemName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SecondHomeDetailViewController()
        vc.datatask = clothItemTasks[indexPath.item]
        transition(vc, transitionStyle: .push)
        print(#function, "\(indexPath.item)")
    }
    
}

