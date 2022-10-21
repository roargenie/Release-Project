

import UIKit
import RealmSwift
import YPImagePicker
import FSCalendar

final class DiaryViewController: BaseViewController {
    
    private let mainView = DiaryView()
    
    var selectedDay = Date()
    
    private var pickedImage: UIImage?
    
    private let repository = StyleRepository()
    
    var styleTasks: Results<Style>! {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    var clothItemTasks: Results<ClothItem>!
    
    var categoryTasks: Results<Category>!
    
    var seasonTasks: Results<Season>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRealm()
        mainView.calendar.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        repository.initClothItemIsSelected(item: clothItemTasks)
        repository.initCategoryTagIsSelected(item: categoryTasks)
        repository.initSeasonTagIsSelected(item: seasonTasks)
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
        styleTasks = repository.fetchDateFilter(date: date)
        clothItemTasks = repository.fetch(ClothItem.self)
        seasonTasks = repository.fetch(Season.self)
        categoryTasks = repository.fetch(Category.self)
    }
    
    override func setNavigationBar() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        self.navigationItem.rightBarButtonItems = [plusButton]
    }
    
    @objc private func plusButtonTapped() {
        let vc = DiaryDetailViewController()
        vc.selectedDay = selectedDay
        vc.clothItemTasks = repository.fetch(ClothItem.self)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.backButtonTitle = ""
        transition(vc, transitionStyle: .push)
    }
    
}


extension DiaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainView.emptyViewLabel.isHidden = styleTasks.count != 0 ? true : false
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
    
}

extension DiaryViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return repository.fetchDateFilter(date: date).count
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDay = date
        styleTasks = repository.fetchDateFilter(date: date)
    }
}
