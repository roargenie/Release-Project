

import UIKit
import Floaty


final class AddItemView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(AddItemCollectionViewCell.self, forCellWithReuseIdentifier: AddItemCollectionViewCell.reuseIdentifier)
        view.register(AddItemCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AddItemCollectionReusableView.identifier)
        view.backgroundColor = .systemBlue
        return view
    }()
    
//    let addItemButton: Floaty = {
//        let view = Floaty()
//        view.addItem("앨범에서 추가하기", icon: UIImage(systemName: "photo"))
//
//        view.openAnimationType = .pop
//        return view
//    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [collectionView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
//        addItemButton.snp.makeConstraints { make in
//            make.bottom.trailing.equalTo(self.safeAreaLayoutGuide).offset(-30)
//            make.width.height.equalTo(30)
//        }
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 10) / 2
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.headerReferenceSize = CGSize(width: deviceWidth, height: 250)
        layout.scrollDirection = .vertical
        return layout
    }
}
