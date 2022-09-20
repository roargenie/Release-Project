

import UIKit



final class DiaryTableViewCell: BaseTableViewCell {
    
    let styleImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let diaryLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.text = "dsdfsdfsdfsdfsdf"
        return view
    }()
    
    lazy var diaryStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [styleImageView, diaryLabel])
        view.spacing = 20
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [diaryStackView].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        
        styleImageView.snp.makeConstraints { make in
            make.width.equalTo(diaryStackView.snp.width).multipliedBy(0.4)
        }
        
        diaryStackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        
    }
    
}
