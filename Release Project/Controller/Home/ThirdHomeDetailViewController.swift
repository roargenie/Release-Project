

import UIKit
import RealmSwift


final class ThirdHomeDetailViewController: BaseViewController {
    
    var mainView = ThirdHomeDetailView()
    
    fileprivate let repository = StyleRepository()
    
    var dataTasks = Style()
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var styleTasks: Results<Style>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 150
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        
    }
    
    func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self)
        styleTasks = repository.fetch(Style.self)
    }
    
}


extension ThirdHomeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTasks.clothItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdHomeDetailTableViewCell.reuseIdentifier, for: indexPath) as? ThirdHomeDetailTableViewCell else { return UITableViewCell() }
        
        let task = dataTasks
        var seasonArr: [String] = []
        
        for i in task.season {
            seasonArr.append(i.title)
        }
        let seasonStr = seasonArr.joined(separator: ", ")
        
        cell.categoryLabel.text = task.clothItem[indexPath.row].category.first?.title
        cell.seasonLabel.text = seasonStr
        cell.wornCountLabel.text = String(task.clothItem[indexPath.row].wornCount)
        
        return cell
    }
    
}
