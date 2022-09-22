

import UIKit


final class HomeViewThirdTableViewCell: BaseTableViewCell {
        
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(HomeViewThirdCollectionViewCell.self, forCellWithReuseIdentifier: HomeViewThirdCollectionViewCell.reuseIdentifier)
        return view
    }()
//    let favoriteItemButton: UIButton = {
//        let view = UIButton()
//        view.backgroundColor = .systemGreen
//        view.setTitle("이번주 코디한번 볼까?", for: .normal)
//        view.setTitleColor(UIColor.white, for: .normal)
//        view.layer.cornerRadius = 15
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowOffset = CGSize(width: 3, height: 3)
//        return view
//    }()
//
//    let notOftenItemButton: UIButton = {
//        let view = UIButton()
//        view.backgroundColor = .systemGreen
//        view.setTitle("이번주엔 무슨옷을 입었지?", for: .normal)
//        view.setTitleColor(UIColor.white, for: .normal)
//        view.layer.cornerRadius = 15
//        view.layer.shadowColor = UIColor.gray.cgColor
//        view.layer.shadowOpacity = 0.5
//        view.layer.shadowOffset = CGSize(width: 3, height: 3)
//        return view
//    }()
//
//    lazy var stackView: UIStackView = {
//        let view = UIStackView(arrangedSubviews: [favoriteItemButton, notOftenItemButton])
//        view.axis = .vertical
//        view.spacing = 20
//        view.alignment = .fill
//        view.distribution = .fillEqually
//        return view
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        self.contentView.addSubview(collectionView)
    }
    
    override func setConstraints() {
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
//            make.height.equalTo(200)
//        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
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
        layout.scrollDirection = .horizontal
        return layout
    }
    
}
