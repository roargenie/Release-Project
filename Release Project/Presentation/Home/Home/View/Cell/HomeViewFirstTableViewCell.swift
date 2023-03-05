

import UIKit



final class HomeViewFirstTableViewCell: BaseTableViewCell {
    
    let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let tempLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .black
        view.font = .systemFont(ofSize: 40, weight: .heavy)
        return view
    }()
    
    let weatherLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .gray
        view.font = .systemFont(ofSize: 13, weight: .bold)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [weatherImageView, weatherLabel, tempLabel].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
        }
        tempLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(36)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(80)
        }
        weatherLabel.snp.makeConstraints { make in
            make.leading.equalTo(tempLabel.snp.trailing).offset(4)
            make.bottom.equalTo(tempLabel.snp.bottom)
        }
    }
    
}
