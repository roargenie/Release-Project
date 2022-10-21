

import UIKit



final class SettingViewController: BaseViewController {
    
    private let mainView = SettingView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        mainView.collectionView.delegate = self
        self.title = "설정"
    }
    
}

extension SettingViewController {
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SettingCollectionViewCell, String> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource (collectionView: mainView.collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0, 1, 2])
        snapshot.appendItems(SettingTitle.notice.title, toSection: 0)
        snapshot.appendItems(SettingTitle.fileManage.title, toSection: 1)
        snapshot.appendItems(SettingTitle.info.title, toSection: 2)
        dataSource.apply(snapshot)
    }
}

extension SettingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
