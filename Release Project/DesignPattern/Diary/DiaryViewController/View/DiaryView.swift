

import UIKit
import FSCalendar

final class DiaryView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.reuseIdentifier)
        view.separatorInset = .zero
        view.backgroundColor = .white
        return view
    }()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .white
        view.locale = Locale(identifier: "ko_KR")
        view.appearance.headerMinimumDissolvedAlpha = 0
        view.appearance.weekdayTextColor = .black
        view.appearance.headerDateFormat = "YYYY년 MM월"
        view.appearance.headerTitleColor = UIColor.black
        view.appearance.calendar.headerHeight = 50
        view.appearance.headerTitleAlignment = .center
        view.appearance.titleWeekendColor = .red
        return view
    }()
    
    let emptyViewLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textColor = .systemGray2
        view.text = "다이어리를 작성해 주세요 :)"
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [tableView, calendar, emptyViewLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.snp.height).multipliedBy(0.4)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        emptyViewLabel.snp.makeConstraints { make in
            make.center.equalTo(tableView.snp.center)
        }
    }
    
    
}



