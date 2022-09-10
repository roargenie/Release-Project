

import UIKit


final class HomeView: BaseView {
    
    let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.backgroundColor = .gray
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
    
    let firstLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let weatherStyleButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        view.setTitle("오늘 날씨에 이런 스타일은 어때요?", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 12)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    let weatherItemButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemBlue
        view.setTitle("오늘 날씨에 이런 아이템은 어때요?", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 12)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    let secondLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let favoriteItemButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("이달의 최애템❣️", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    let notOftenItemButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        view.setTitle("이 옷을 잊어버리신건 아니겠죠?", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    let previousMonthExpendLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 2
        view.text = "전달의 소비액\n500,000₩"
        return view
    }()
    
    let currentMonthExpendLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 2
        view.text = "이달의 소비액\n1,000,000₩"
        return view
    }()
    
    let thirdLineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [weatherImageView, weatherLabel, firstLineView, weatherStyleButton, weatherItemButton, secondLineView, favoriteItemButton, notOftenItemButton, previousMonthExpendLabel, currentMonthExpendLabel,thirdLineView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.width.height.equalTo(100)
        }
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(weatherImageView.snp.leading).offset(-12)
            make.height.equalTo(70)
        }
        firstLineView.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(2)
        }
        weatherStyleButton.snp.makeConstraints { make in
            make.top.equalTo(firstLineView.snp.bottom).offset(20)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(0.5)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.43)
        }
        weatherItemButton.snp.makeConstraints { make in
            make.centerY.equalTo(weatherStyleButton.snp.centerY)
            make.centerX.equalTo(self.snp.centerX).multipliedBy(1.5)
            make.width.height.equalTo(self.snp.width).multipliedBy(0.43)
        }
        secondLineView.snp.makeConstraints { make in
            make.top.equalTo(weatherStyleButton.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(2)
        }
        favoriteItemButton.snp.makeConstraints { make in
            make.top.equalTo(secondLineView.snp.bottom).offset(20)
            make.leading.equalTo(weatherStyleButton.snp.leading)
            make.trailing.equalTo(weatherItemButton.snp.trailing)
            make.height.equalTo(60)
        }
        notOftenItemButton.snp.makeConstraints { make in
            make.top.equalTo(favoriteItemButton.snp.bottom).offset(20)
            make.leading.equalTo(weatherStyleButton.snp.leading)
            make.trailing.equalTo(weatherItemButton.snp.trailing)
            make.height.equalTo(60)
        }
        thirdLineView.snp.makeConstraints { make in
            make.top.equalTo(notOftenItemButton.snp.bottom).offset(40)
            make.height.equalTo(70)
            make.width.equalTo(2)
            make.centerX.equalTo(self.snp.centerX)
        }
        previousMonthExpendLabel.snp.makeConstraints { make in
            make.trailing.equalTo(thirdLineView.snp.leading).offset(-12)
            make.centerY.equalTo(thirdLineView.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        currentMonthExpendLabel.snp.makeConstraints { make in
            make.leading.equalTo(thirdLineView.snp.trailing).offset(12)
            make.centerY.equalTo(thirdLineView.snp.centerY)
            make.width.equalTo(self.snp.width).multipliedBy(0.4)
            make.height.equalTo(50)
        }
        
    }
    
}




