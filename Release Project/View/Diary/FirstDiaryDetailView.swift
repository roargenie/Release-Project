

import UIKit
import SnapKit
import YPImagePicker

final class FirstDiaryDetailView: BaseView {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        view.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.reuseIdentifier)
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("취소", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        return view
    }()
    
    let doneButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .darkGray
        return view
    }()
    
    let addImageButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "photo"), for: .normal)
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 2
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
    
    let seasonLabel: UILabel = {
        let view = UILabel()
        view.text = "계절"
        return view
    }()
    
    let springTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("봄", for: .normal)
        return view
    }()
    
    let summerTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("여름", for: .normal)
        return view
    }()
    
    let autumnTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("가을", for: .normal)
        return view
    }()
    
    let winterTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("겨울", for: .normal)
        return view
    }()
    
    lazy var secondStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [springTagButton, summerTagButton, autumnTagButton, winterTagButton])
        view.axis = .horizontal
        view.spacing = 15
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [collectionView, doneButton, cancelButton, firstStackView, addImageButton, seasonLabel, secondStackView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(secondStackView.snp.bottom).offset(30)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.width.height.equalTo(40)
        }
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16)
            make.width.height.equalTo(40)
        }
        firstStackView.snp.makeConstraints { make in
            make.top.equalTo(doneButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
        imageView.snp.makeConstraints { make in
            make.width.equalTo(firstStackView.snp.width).multipliedBy(0.4)
        }
        addImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.bottom.equalTo(imageView.snp.bottom).offset(-8)
            make.trailing.equalTo(imageView.snp.trailing).offset(-8)
        }
        seasonLabel.snp.makeConstraints { make in
            make.top.equalTo(firstStackView.snp.bottom).offset(16)
            make.leading.equalTo(firstStackView.snp.leading)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        secondStackView.snp.makeConstraints { make in
            make.top.equalTo(seasonLabel.snp.bottom).offset(16)
            make.leading.equalTo(firstStackView.snp.leading)
            make.trailing.equalTo(firstStackView.snp.trailing)
            make.height.equalTo(40)
        }
        
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemSize: CGFloat = (deviceWidth - 20) / 3
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        //layout.headerReferenceSize = CGSize(width: deviceWidth, height: 350)
        layout.scrollDirection = .vertical
        return layout
    }
}
