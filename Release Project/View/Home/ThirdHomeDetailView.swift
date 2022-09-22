

import UIKit


final class ThirdHomeDetailView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(ThirdHomeDetailTableViewCell.self, forCellReuseIdentifier: ThirdHomeDetailTableViewCell.reuseIdentifier)
        view.register(ThirdHomeDetailCustomHeaderView.self, forHeaderFooterViewReuseIdentifier: ThirdHomeDetailCustomHeaderView.identifier)
        view.backgroundColor = .white
        view.separatorInset = .zero
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
