

import UIKit
import SnapKit
import YPImagePicker

final class FirstDiaryDetailView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)
        view.backgroundColor = .white
        return view
    }()
    
    let seasonCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: seasonCollectionViewLayout())
        view.register(DetailSeasonCollectionViewCell.self, forCellWithReuseIdentifier: DetailSeasonCollectionViewCell.reuseIdentifier)
        view.register(FirstAddItemDetailCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FirstAddItemDetailCollectionReusableView.identifier)
        view.backgroundColor = .white
        return view
    }()
    
    let categoryTabbarCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: categoryTabbarCollectionViewLayout())
        view.register(DetailTabbarCollectionViewCell.self, forCellWithReuseIdentifier: DetailTabbarCollectionViewCell.reuseIdentifier)
        view.backgroundColor = .white
        view.keyboardDismissMode = .onDrag
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var firstStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, textView])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .fill
        view.distribution = .fill
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [collectionView, seasonCollectionView, categoryTabbarCollectionView, firstStackView, emptyViewLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(categoryTabbarCollectionView.snp.bottom)
        }
        seasonCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstStackView.snp.bottom)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(categoryTabbarCollectionView.snp.top)
            make.height.equalTo(130)
        }
        categoryTabbarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(seasonCollectionView.snp.bottom)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        firstStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
        imageView.snp.makeConstraints { make in
            make.width.equalTo(firstStackView.snp.width).multipliedBy(0.4)
        }
        emptyViewLabel.snp.makeConstraints { make in
            make.center.equalTo(collectionView.snp.center)
        }
        
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 52) / 3
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        //layout.headerReferenceSize = CGSize(width: deviceWidth, height: 350)
        layout.scrollDirection = .vertical
        return layout
    }
    
    static func seasonCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 50) / 4
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        layout.itemSize = CGSize(width: itemSize, height: 42)
        layout.headerReferenceSize = CGSize(width: deviceWidth, height: 65)
        layout.scrollDirection = .vertical
        return layout
    }
    
    static func categoryTabbarCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 50) / 4
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        layout.itemSize = CGSize(width: itemSize, height: 32)
        //layout.headerReferenceSize = CGSize(width: deviceWidth, height: 75)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
    
}
