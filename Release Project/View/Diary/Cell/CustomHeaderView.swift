

import UIKit
import FSCalendar

final class CustomHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CustomHeaderView"
    
    lazy var calendar: FSCalendar = {
        let view = FSCalendar()
        view.backgroundColor = .white
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


