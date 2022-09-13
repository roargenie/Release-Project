

import UIKit



final class DetailCustomHeaderView: UICollectionReusableView {
    
    static let identifier = "DetailCustomHeaderView"
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
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
        
        return view
    }()
    
    lazy var firstStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, textView])
        view.axis = .horizontal
        view.spacing = 15
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
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [firstStackView, seasonLabel, secondStackView, addImageButton].forEach { self.addSubview($0) }
        
    }
    
    func setConstraints() {
        firstStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
        }
        imageView.snp.makeConstraints { make in
            make.width.equalTo(firstStackView.snp.width).multipliedBy(0.35)
        }
        addImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
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
    
}
