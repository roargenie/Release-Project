

import UIKit
import RealmSwift
import PanModal




final class AddItemPanModalVC: BaseViewController {
    
    private let mainView = AddItemPanModalView()
    
    private let repository = StyleRepository.shared
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var categoryTasks: Results<Category>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var dataSendClosure: ((Results<ClothItem>) -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRealm()
        print(#function)
    }
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 50
    }
    
    private func fetchRealm() {
        categoryTasks = repository.fetch(Category.self)
    }
}

extension AddItemPanModalVC: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return mainView.tableView
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(350)
    }
    
    var cornerRadius: CGFloat {
        return 25
    }
    
    var showDragIndicator: Bool {
        return false
    }
    
    var anchorModalToLongForm: Bool {
        return true
    }
}

extension AddItemPanModalVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return categoryTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddItemPanModalTableViewCell.reuseIdentifier, for: indexPath) as? AddItemPanModalTableViewCell else { return UITableViewCell() }
        if indexPath.section == 0 {
            cell.sortTypeLabel.text = "전체"
            cell.selectionStyle = .none
            return cell
        } else {
            let task = categoryTasks[indexPath.row]
            cell.sortTypeLabel.text = task.title
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            dataSendClosure?(repository.fetch(ClothItem.self).sorted(byKeyPath: "regDate", ascending: false))
            self.dismiss(animated: true)
        } else {
            switch indexPath.row {
            case 0:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "아우터"))
            case 1:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "상의"))
            case 2:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "하의"))
            case 3:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "신발"))
            case 4:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "악세"))
            case 5:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "기타"))
            default:
                break
            }
            self.dismiss(animated: true)
        }
    }
    
}
