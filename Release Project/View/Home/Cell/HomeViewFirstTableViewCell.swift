

import UIKit



final class HomeViewFirstTableViewCell: BaseTableViewCell {
    
    let weatherImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "Rain.png"))
        view.contentMode = .scaleToFill
        //view.backgroundColor = .gray
        return view
    }()
    
    let weatherLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .black
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.text = "오늘의 날씨는 주륵주륵 비가내려요.\n최고 온도는 27도 최저 온도는 24도 입니다.\n우산을 꼭 챙기세요☔️"
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [weatherImageView, weatherLabel].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
        }
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.centerY)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-70)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
    }
    
}
