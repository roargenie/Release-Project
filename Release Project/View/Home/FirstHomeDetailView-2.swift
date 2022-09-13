

import UIKit



final class FirstHomeDetailView2: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(FirstHomeDetailCollectionViewCell.self, forCellWithReuseIdentifier: FirstHomeDetailCollectionViewCell.reuseIdentifier)
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [collectionView, cancelButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.width.equalTo(20)
        }
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

