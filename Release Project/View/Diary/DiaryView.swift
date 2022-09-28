

import UIKit
import FSCalendar

final class DiaryView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(DiaryTableViewCell.self, forCellReuseIdentifier: DiaryTableViewCell.reuseIdentifier)
//        view.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)
        view.separatorInset = .zero
        view.backgroundColor = .white
        return view
    }()
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .white
        view.locale = Locale(identifier: "ko_KR")
        view.appearance.headerMinimumDissolvedAlpha = 0.2
        //view.appearance.headerTitleFont = UIFont(name: "NotoSansKR-Medium", size: 24)
        //view.appearance.weekdayFont = UIFont(name: "NotoSansKR-Regular", size: 2)
        view.appearance.weekdayTextColor = .gray
        //view.appearance.titleFont = UIFont(name: "NotoSansKR-Regular", size: 2)
        view.appearance.headerDateFormat = "YYYY년 MM월"
        view.appearance.headerTitleColor = UIColor.black
        view.appearance.calendar.headerHeight = 60
        view.appearance.headerTitleAlignment = .center
//        view.appearance.eventDefaultColor = .red
//        view.appearance.eventSelectionColor = .red
        view.appearance.titleWeekendColor = .red
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [tableView, calendar].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}



