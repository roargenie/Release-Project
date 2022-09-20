

import UIKit
import RealmSwift
import YPImagePicker


final class DiaryViewController: BaseViewController {
    
    var mainView = DiaryView()
    
    var pickedImage: UIImage?
    
    fileprivate let repository = StyleRepository()
    
    var styleTasks: Results<Style>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRealm()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 150
        mainView.tableView.sectionHeaderHeight = 300
        mainView.tableView.sectionFooterHeight = 0
    }
    
    override func setConstraints() {
        
    }
    
    func fetchRealm() {
        styleTasks = repository.fetch(Style.self)
    }
    
    override func setNavigationBar() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        self.navigationItem.rightBarButtonItems = [plusButton]
    }
    
    @objc func plusButtonTapped() {
        let vc = DiaryDetailViewController()
        vc.clothItemTasks = repository.fetch(ClothItem.self)
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
}


extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return styleTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.reuseIdentifier, for: indexPath) as? DiaryTableViewCell else { return UITableViewCell() }
        
        let task = styleTasks[indexPath.row]
        
        cell.diaryLabel.text = task.contents
        cell.styleImageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DiarySecondDetailViewController()
        self.tabBarController?.tabBar.isHidden = true
        transition(vc, transitionStyle: .push)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as? CustomHeaderView else { return UIView() }
        
        
        return headerView
    }
    
    
}

