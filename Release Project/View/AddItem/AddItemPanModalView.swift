

import UIKit



final class AddItemPanModalView: BaseView {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "카테고리별 정렬"
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 22, weight: .heavy)
        view.textColor = .black
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(AddItemPanModalTableViewCell.self, forCellReuseIdentifier: AddItemPanModalTableViewCell.reuseIdentifier)
        view.separatorStyle = .none
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [tableView, titleLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.snp.height).multipliedBy(0.15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
