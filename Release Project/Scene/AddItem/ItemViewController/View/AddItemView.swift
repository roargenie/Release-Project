

import UIKit



final class AddItemView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(AddItemCollectionViewCell.self, forCellWithReuseIdentifier: AddItemCollectionViewCell.reuseIdentifier)
        view.backgroundColor = .white
        return view
    }()
    
    let emptyViewLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .systemGray2
        view.text = "아이템을 등록해 주세요 :)"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [collectionView, emptyViewLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        emptyViewLabel.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 42) / 2
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        //layout.headerReferenceSize = CGSize(width: deviceWidth, height: 250)
        layout.scrollDirection = .vertical
        return layout
    }
}
