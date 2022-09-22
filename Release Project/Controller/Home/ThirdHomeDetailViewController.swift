

import UIKit
import RealmSwift


final class ThirdHomeDetailViewController: BaseViewController {
    
    private var mainView = ThirdHomeDetailView()
    
    private let repository = StyleRepository()
    
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
        mainView.tableView.sectionHeaderHeight = 300
        mainView.tableView.sectionFooterHeight = 0
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        
    }
    
    private func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self)
        //styleTasks = repository.fetch(Style.self)
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
        for i in task.clothItem[indexPath.item].season {
            seasonArr.append(i.title)
        }
        let seasonStr = seasonArr.joined(separator: ", ")
        
        cell.clothImageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.clothItem[indexPath.row].objectId).jpg")
        cell.categoryLabel.text = "카테고리 : \(task.clothItem[indexPath.row].category.first?.title ?? "선택안함")"
        cell.seasonLabel.text = "계절 : \(seasonStr)"
        cell.wornCountLabel.text = "착용횟수 : \(String(task.clothItem[indexPath.row].wornCount))"
        cell.regDateLabel.text = "등록일 : \(task.regDate.formatted())"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ThirdHomeDetailCustomHeaderView.identifier) as? ThirdHomeDetailCustomHeaderView else { return UIView() }
        
        let task = dataTasks
        
        headerView.styleImageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return headerView
    }
    
}
