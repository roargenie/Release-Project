

import UIKit


final class ThirdHomeDetailTableViewCell: BaseTableViewCell {
    
    let clothImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "shirts.jpeg"))
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let categoryLabel: UILabel = {
        let view = UILabel()
        view.text = "카테고리 : 아우터"
        return view
    }()
    
    let seasonLabel: UILabel = {
        let view = UILabel()
        view.text = "계절 : 가을, 겨울"
        return view
    }()
    
    let wornCountLabel: UILabel = {
        let view = UILabel()
        view.text = "착용횟수 : 4"
        return view
    }()
    
    let regDateLabel: UILabel = {
        let view = UILabel()
        view.text = "등록일 : 2022.07.09"
        return view
    }()
    
    lazy var labelStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [categoryLabel, seasonLabel, wornCountLabel, regDateLabel])
        view.axis = .vertical
        view.spacing = 5
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
        [clothImageView, labelStackView].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        clothImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
        }
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(clothImageView.snp.top)
            make.bottom.equalTo(clothImageView.snp.bottom)
            make.leading.equalTo(clothImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
        
        
    }
    
}





