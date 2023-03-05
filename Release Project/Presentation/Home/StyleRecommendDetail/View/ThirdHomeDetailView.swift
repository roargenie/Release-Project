

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
    
    override func configureUI() {
        [tableView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
