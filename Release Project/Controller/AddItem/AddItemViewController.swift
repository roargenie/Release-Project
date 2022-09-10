

import UIKit
import Floaty

final class AddItemViewController: BaseViewController {
    
    var mainView = AddItemView()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func configureUI() {
        
    }
    
    override func setConstraints() {
        
    }
    
}

extension AddItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddItemCollectionViewCell.reuseIdentifier, for: indexPath) as? AddItemCollectionViewCell else { return UICollectionViewCell()}
        cell.imageView.backgroundColor = .systemGray3
        cell.itemLabel.text = "아이템 이름"
        
        return cell
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





