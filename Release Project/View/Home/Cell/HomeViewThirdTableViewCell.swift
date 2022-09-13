

import UIKit


final class HomeViewThirdTableViewCell: BaseTableViewCell {
    
    let favoriteItemButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("이달의 최애템❣️", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    let notOftenItemButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("이 옷을 잊어버리신건 아니겠죠?", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [favoriteItemButton, notOftenItemButton])
        view.axis = .vertical
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
        self.contentView.addSubview(stackView)
    }
    
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(200)
        }
    }
    
    
}
