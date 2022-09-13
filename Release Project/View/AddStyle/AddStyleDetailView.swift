

import UIKit




final class AddStyleDetailView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(AddStyleDetailCollectionViewCell.self, forCellWithReuseIdentifier: AddStyleDetailCollectionViewCell.reuseIdentifier)
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private let imageBoard: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [collectionView, imageBoard].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imageBoard.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(imageBoard.snp.bottom).offset(60)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 20) / 3
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        //layout.headerReferenceSize = CGSize(width: deviceWidth, height: 250)
        layout.scrollDirection = .vertical
        return layout
    }
}
