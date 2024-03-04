

import UIKit


final class HomeViewThirdTableViewCell: BaseTableViewCell {
        
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(HomeViewThirdCollectionViewCell.self, forCellWithReuseIdentifier: HomeViewThirdCollectionViewCell.reuseIdentifier)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .brown
        return view
    }()
    
    let button: UIButton = {
        let view = UIButton()
        view.setTitle("테스트", for: .normal)
        view.backgroundColor = .red
        return view
    }()
    
    let emptyViewLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .systemGray2
        view.text = "다이어리를 작성해 주세요 :)"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [collectionView, emptyViewLabel, button].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.width.height.equalTo(30)
        }
//        collectionView.snp.makeConstraints { make in
//            make.top.equalTo(button.snp.bottom).offset(4)
//            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
//            make.bottom.equalTo(self.safeAreaLayoutGuide)
////            make.edges.equalTo(self.safeAreaLayoutGuide)
//        }
        emptyViewLabel.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 42) / 2
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: itemSize - 12, height: itemSize - 12)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.scrollDirection = .horizontal
        return layout
    }
}
