

import UIKit



final class HomeViewSecondTableViewCell: BaseTableViewCell {
    
    let weatherStyleButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .black
        view.setTitle("스타일을 추천받을게요!", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        return view
    }()
    
    let weatherItemButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .black
        view.setTitle("아이템을 추천받을게요!", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [weatherStyleButton, weatherItemButton])
        view.axis = .horizontal
        view.spacing = 16
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
        [stackView].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
            //make.height.equalTo(100)
        }
    }
    
}