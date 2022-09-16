

import UIKit
import YPImagePicker


final class DiaryViewController: BaseViewController {
    
    var mainView = DiaryView()
    
    var pickedImage: UIImage?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func setNavigationBar() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        self.navigationItem.rightBarButtonItems = [plusButton]
    }
    
    @objc func plusButtonTapped() {
        let vc = DiaryDetailViewController()
        transition(vc, transitionStyle: .presentFull)

    }
    
}


extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.reuseIdentifier, for: indexPath) as? DiaryTableViewCell else { return UITableViewCell() }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DiarySecondDetailViewController()
        transition(vc, transitionStyle: .push)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as? CustomHeaderView else { return UIView() }
        
        
        return headerView
    }
    
    
}

