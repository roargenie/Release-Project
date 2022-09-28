

import UIKit


final class HomeView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(HomeViewFirstTableViewCell.self, forCellReuseIdentifier: HomeViewFirstTableViewCell.reuseIdentifier)
        view.register(HomeViewSecondTableViewCell.self, forCellReuseIdentifier: HomeViewSecondTableViewCell.reuseIdentifier)
        view.register(HomeViewThirdTableViewCell.self, forCellReuseIdentifier: HomeViewThirdTableViewCell.reuseIdentifier)
        view.register(HomeViewFourthTableViewCell.self, forCellReuseIdentifier: HomeViewFourthTableViewCell.reuseIdentifier)
        view.register(ReusableHeaderView.self, forHeaderFooterViewReuseIdentifier: ReusableHeaderView.identifier)
        view.backgroundColor = .white
        view.separatorStyle = .none
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




