

import UIKit


final class HomeViewFourthTableViewCell: BaseTableViewCell {
    
    let outerImageView: CustomImageView = {
        let view = CustomImageView(image: UIImage(named: "Outer.png"))
        view.contentMode = .scaleToFill
        return view
    }()
    
    let outerPercentLabel: UILabel = {
        let view = UILabel()
        view.text = "30%"
        return view
    }()
    
    lazy var outerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [outerImageView, outerPercentLabel])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    let topImageView: CustomImageView = {
        let view = CustomImageView(image: UIImage(named: "Top.png"))
        view.contentMode = .scaleToFill
        return view
    }()
    
    let topPercentLabel: UILabel = {
        let view = UILabel()
        view.text = "30%"
        return view
    }()
    
    lazy var topStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [topImageView, topPercentLabel])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    lazy var outerAndTopStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [outerStackView, topStackView])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    let pantsImageView: CustomImageView = {
        let view = CustomImageView(image: UIImage(named: "Pants.png"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let pantsPercentLabel: UILabel = {
        let view = UILabel()
        view.text = "30%"
        return view
    }()
    
    lazy var pantsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [pantsImageView, pantsPercentLabel])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    let shoesImageView: CustomImageView = {
        let view = CustomImageView(image: UIImage(named: "Shoes.png"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let shoesPercentLabel: UILabel = {
        let view = UILabel()
        view.text = "30%"
        return view
    }()
    
    lazy var shoesStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [shoesImageView, shoesPercentLabel])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    lazy var pantsAndShoesStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [pantsStackView, shoesStackView])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    let accImageView: CustomImageView = {
        let view = CustomImageView(image: UIImage(named: "Acc.png"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let accPercentLabel: UILabel = {
        let view = UILabel()
        view.text = "30%"
        return view
    }()
    
    lazy var accStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [accImageView, accPercentLabel])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    let otherImageView: CustomImageView = {
        let view = CustomImageView(image: UIImage(named: "Cap.png"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let otherPercentLabel: UILabel = {
        let view = UILabel()
        view.text = "30%"
        return view
    }()
    
    lazy var otherStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [otherImageView, otherPercentLabel])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    lazy var accAndOtherStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [accStackView, otherStackView])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [outerAndTopStackView, pantsAndShoesStackView, accAndOtherStackView].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        outerImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        topImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        pantsImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        shoesImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        accImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        otherImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        outerAndTopStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        pantsAndShoesStackView.snp.makeConstraints { make in
            make.top.equalTo(outerAndTopStackView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        accAndOtherStackView.snp.makeConstraints { make in
            make.top.equalTo(pantsAndShoesStackView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        
        
    }
    
}
