

import UIKit


final class AddItemPanModalTableViewCell: BaseTableViewCell {
    
    let sortTypeLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .heavy)
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [sortTypeLabel].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        sortTypeLabel.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
}
