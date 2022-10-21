

import UIKit


final class HomeView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(HomeViewFirstTableViewCell.self, forCellReuseIdentifier: HomeViewFirstTableViewCell.reuseIdentifier)
        view.register(HomeViewSecondTableViewCell.self, forCellReuseIdentifier: HomeViewSecondTableViewCell.reuseIdentifier)
        view.register(HomeViewThirdTableViewCell.self, forCellReuseIdentifier: HomeViewThirdTableViewCell.reuseIdentifier)
        view.register(HomeViewFourthTableViewCell.self, forCellReuseIdentifier: HomeViewFourthTableViewCell.reuseIdentifier)
        view.register(ReusableHeaderView.self, forHeaderFooterViewReuseIdentifier: ReusableHeaderView.identifier)
        view.backgroundColor = Color.backGroundColor
        view.separatorStyle = .none
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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




