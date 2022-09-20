

import UIKit


final class HomeDetailCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "HomeDetailCollectionReusableView"
    
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "shirts.jpeg"))
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var categoryView: CustomUIView = {
        let view = CustomUIView()
        [categoryTitleLable, categoryContentLabel].forEach { view.addSubview($0) }
        return view
    }()
    
    let categoryTitleLable: UILabel = {
        let view = UILabel()
        view.text = "카테고리"
        view.textAlignment = .center
        return view
    }()
    
    let categoryContentLabel: UILabel = {
        let view = UILabel()
        //view.text = "아우터"
        view.textAlignment = .center
        return view
    }()
    
    lazy var seasonView: CustomUIView = {
        let view = CustomUIView()
        [seasonTitleLabel, seasonContentLabel].forEach { view.addSubview($0) }
        return view
    }()
    
    let seasonTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "계절"
        view.textAlignment = .center
        return view
    }()
    
    let seasonContentLabel: UILabel = {
        let view = UILabel()
        //view.text = "봄, 여름"
        view.textAlignment = .center
        return view
    }()
    
    lazy var wornCountView: CustomUIView = {
        let view = CustomUIView()
        [wornCountTitleLabel, wornCountContentLabel].forEach { view.addSubview($0) }
        return view
    }()
    
    let wornCountTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "착용횟수"
        view.textAlignment = .center
        return view
    }()
    
    let wornCountContentLabel: UILabel = {
        let view = UILabel()
        //view.text = "5"
        view.textAlignment = .center
        return view
    }()
    
    lazy var viewStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [categoryView, seasonView, wornCountView])
        view.axis = .horizontal
        view.spacing = 15
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: ""), for: .normal)
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
        [imageView, viewStackView].forEach { self.addSubview($0) }
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(self.snp.height).multipliedBy(0.65)
        }
        viewStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        categoryTitleLable.snp.makeConstraints { make in
            make.centerY.equalTo(categoryView.snp.centerY).multipliedBy(0.6)
            make.centerX.equalTo(categoryView.snp.centerX)
            make.height.equalTo(categoryView.snp.height).multipliedBy(0.4)
        }
        categoryContentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryView.snp.centerY).multipliedBy(1.4)
            make.centerX.equalTo(categoryView.snp.centerX)
            make.height.equalTo(categoryView.snp.height).multipliedBy(0.4)
        }
        seasonTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(seasonView.snp.centerY).multipliedBy(0.6)
            make.centerX.equalTo(seasonView.snp.centerX)
            make.height.equalTo(seasonView.snp.height).multipliedBy(0.4)
        }
        seasonContentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(seasonView.snp.centerY).multipliedBy(1.4)
            make.centerX.equalTo(seasonView.snp.centerX)
            make.height.equalTo(seasonView.snp.height).multipliedBy(0.4)
        }
        wornCountTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(wornCountView.snp.centerY).multipliedBy(0.6)
            make.centerX.equalTo(wornCountView.snp.centerX)
            make.height.equalTo(wornCountView.snp.height).multipliedBy(0.4)
        }
        wornCountContentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(wornCountView.snp.centerY).multipliedBy(1.4)
            make.centerX.equalTo(wornCountView.snp.centerX)
            make.height.equalTo(wornCountView.snp.height).multipliedBy(0.4)
        }
        
    }
}
