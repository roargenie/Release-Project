

import UIKit


final class DiaryView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.reuseIdentifier)
        view.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)
        view.separatorInset = .zero
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
        self.addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}



