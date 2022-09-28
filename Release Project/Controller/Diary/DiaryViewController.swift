

import UIKit
import RealmSwift
import YPImagePicker
import FSCalendar

final class DiaryViewController: BaseViewController {
    
    private var mainView = DiaryView()
    
    private var pickedImage: UIImage?
    
    private let repository = StyleRepository()
    
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
        mainView.calendar.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureUI() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.rowHeight = 180
        mainView.tableView.sectionHeaderHeight = 300
        mainView.tableView.sectionFooterHeight = 0
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
    }
    
    override func setConstraints() {
        
    }
    
    private func fetchRealm() {
        guard let date = mainView.calendar.today else { return }
        print(date)
        styleTasks = repository.fetchDateFilter(date: date)
    }
    
    override func setNavigationBar() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        self.navigationItem.rightBarButtonItems = [plusButton]
    }
    
    @objc private func plusButtonTapped() {
        let vc = DiaryDetailViewController()
        vc.clothItemTasks = repository.fetch(ClothItem.self)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.backButtonTitle = ""
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ThirdHomeDetailViewController()
        vc.dataTasks = styleTasks[indexPath.item]
        vc.viewStatus = .edit
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.backButtonTitle = ""
        transition(vc, transitionStyle: .push)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as? CustomHeaderView else { return UIView() }
//        headerView.calendar.delegate = self
//        headerView.calendar.dataSource = self
//        headerView.calendar.reloadData()
//        today = headerView.calendar.today
//
//        return headerView
//    }
    
}

extension DiaryViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDateFilter(date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        styleTasks = repository.fetchDateFilter(date: date)
    }
}
