

import UIKit
import SnapKit
import RealmSwift




final class HomeViewController: BaseViewController {
    
    var mainView = HomeView()
    
    let repository = StyleRepository()
    
    var tasks: Results<ClothItem>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFirstRun()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setConstraints() {
        
    }
    
    @objc func weatherStyleButtonTapped() {
        let vc = FirstHomeDetailViewController1()
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
    @objc func weatherItemButtonTapped() {
        let vc = FirstHomeDetailViewController2()
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
    @objc func favoriteItemButtonTapped() {
        
    }
    
    @objc func notOftenItemButtonTapped() {
        
    }
    
    func fetchRealm() {
        
    }
    
    func checkFirstRun() {
        if UserDefaults.standard.bool(forKey: "FirstRun") == false {
            
            let outer = Category(title: "아우터")
            let top = Category(title: "상의")
            let bottom = Category(title: "하의")
            let shoes = Category(title: "신발")
            let acc = Category(title: "악세")
            let other = Category(title: "기타")
            
            let spring = Season(title: "봄")
            let summer = Season(title: "여름")
            let autumn = Season(title: "가을")
            let winter = Season(title: "겨울")
            repository.addItem(item: [outer, top, bottom, shoes, acc, other, spring, summer, autumn, winter])
            
            print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
            UserDefaults.standard.set(true, forKey: "FirstRun")
        }
        
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewFirstTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewFirstTableViewCell else { return UITableViewCell() }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewSecondTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewSecondTableViewCell else { return UITableViewCell() }
            cell.weatherStyleButton.addTarget(self, action: #selector(weatherStyleButtonTapped), for: .touchUpInside)
            cell.weatherItemButton.addTarget(self, action: #selector(weatherItemButtonTapped), for: .touchUpInside)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewThirdTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewThirdTableViewCell else { return UITableViewCell() }
            cell.favoriteItemButton.addTarget(self, action: #selector(favoriteItemButtonTapped), for: .touchUpInside)
            cell.notOftenItemButton.addTarget(self, action: #selector(notOftenItemButtonTapped), for: .touchUpInside)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewFourthTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewFourthTableViewCell else { return UITableViewCell() }
            
            
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 1:
            return 150
        case 2:
            return 180
        case 3:
            return 320
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReusableHeaderView.identifier) as? ReusableHeaderView else { return UIView() }
        switch section {
        case 0:
            view.headerLabel.text = "오늘의 날씨에요"
        case 1:
            view.headerLabel.text = "오늘 날씨에 맞는 아이템"
        case 2:
            view.headerLabel.text = "나의 옷장은?"
        case 3:
            view.headerLabel.text = "내 옷장은 이렇답니다"
        default:
            break
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
}
