

import UIKit
import FSCalendar

final class CustomHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CustomHeaderView"
    
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
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(calendar)
    }
    
    func setConstraints() {
        calendar.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
            
        }
    }
    
    
    
    
}


