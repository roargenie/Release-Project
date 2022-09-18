

import UIKit
import RealmSwift

final class FirstHomeDetailViewController1: BaseViewController {
    
    var mainView = FirstHomeDetailView1()
    
    fileprivate let repository = StyleRepository()
    
    var styleTasks: Results<Style>! {
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
        styleTasks = repository.fetch(Style.self)
    }
    
    
}

extension FirstHomeDetailViewController1: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styleTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? FirstHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let task = styleTasks[indexPath.item]
        
        cell.imageView.backgroundColor = .green
        cell.itemLabel.text = task.contents
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ThirdHomeDetailViewController()
        vc.dataTasks = styleTasks[indexPath.item]
        transition(vc, transitionStyle: .push)
        print(#function, "\(indexPath.item)")
    }
    
}
