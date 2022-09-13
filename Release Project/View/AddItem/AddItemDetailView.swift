

import UIKit


final class AddItemDetailView: BaseView {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - 카테고리 태그 버튼
    
    private let categoryLabel: UILabel = {
        let view = UILabel()
        view.text = "카테고리"
        return view
    }()
    
    private let outerTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Outer", for: .normal)
        return view
    }()
    
    private let topTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Top", for: .normal)
        return view
    }()
    
    private let bottomTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Bottom", for: .normal)
        return view
    }()
    
    private let shoesTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Shoes", for: .normal)
        return view
    }()
    
    private let accTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Acc", for: .normal)
        return view
    }()
    
    private let otherTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Other", for: .normal)
        return view
    }()
    
    private lazy var categoryStackView1: UIStackView = {
        let view = UIStackView(arrangedSubviews: [outerTagButton, topTagButton, bottomTagButton, shoesTagButton])
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var categoryStackView2: UIStackView = {
        let view = UIStackView(arrangedSubviews: [accTagButton, otherTagButton])
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    // MARK: - 계절 태그 버튼
    
    private let seasonLabel: UILabel = {
        let view = UILabel()
        view.text = "계절"
        return view
    }()
    
    private let springTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Spring", for: .normal)
        return view
    }()
    
    private let summerTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Summer", for: .normal)
        return view
    }()
    
    private let autumnTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Fall", for: .normal)
        return view
    }()
    
    private let winterTagButton: TagButton = {
        let view = TagButton()
        view.setTitle("Winter", for: .normal)
        return view
    }()
    
    private lazy var seasonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [springTagButton, summerTagButton, autumnTagButton, winterTagButton])
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    // MARK: - 구매한 목록에 표시할지 여부
    
    private let amountLabel: UILabel = {
        let view = UILabel()
        view.text = "구매가"
        return view
    }()
    
    private let purchaseCheckBox: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        return view
    }()
    
    private let amountTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "상품가격을 입력해주세요"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [imageView, categoryLabel, categoryStackView1, categoryStackView2, seasonLabel, seasonStackView, amountLabel, purchaseCheckBox, amountTextField, doneButton, cancelButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.width.height.equalTo(50)
        }
        doneButton.snp.makeConstraints { make in
            make.centerY.equalTo(cancelButton.snp.centerY)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-12)
            make.width.height.equalTo(50)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalTo(imageView.snp.leading)
            make.height.equalTo(30)
        }
        categoryStackView1.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(12)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
        categoryStackView2.snp.makeConstraints { make in
            make.top.equalTo(categoryStackView1.snp.bottom).offset(10)
            make.leading.equalTo(categoryStackView1.snp.leading)
            make.trailing.equalTo(topTagButton.snp.trailing)
            make.height.equalTo(30)
        }
        seasonLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryStackView2.snp.bottom).offset(16)
            make.leading.equalTo(categoryLabel.snp.leading)
            make.height.equalTo(30)
        }
        seasonStackView.snp.makeConstraints { make in
            make.top.equalTo(seasonLabel.snp.bottom).offset(12)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonStackView.snp.bottom).offset(16)
            make.leading.equalTo(categoryLabel.snp.leading)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        purchaseCheckBox.snp.makeConstraints { make in
            make.centerY.equalTo(amountLabel.snp.centerY)
            make.leading.equalTo(amountLabel.snp.trailing).offset(12)
            make.width.height.equalTo(25)
        }
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(16)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }

    }
    
    
}
