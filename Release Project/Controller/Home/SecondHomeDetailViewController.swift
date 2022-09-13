

import UIKit



final class SecondHomeDetailViewController: BaseViewController {
    
    var mainView = SecondHomeDetailView()
    
    override func loadView() {
        self.view = mainView
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
    
}


extension SecondHomeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .systemMint
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeDetailCollectionReusableView.identifier, for: indexPath) as! HomeDetailCollectionReusableView
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
