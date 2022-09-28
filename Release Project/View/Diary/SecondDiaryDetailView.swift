

import UIKit



final class SecondDiaryDetailView: BaseView {
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setTitle("취소", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        return view
    }()
    
    let regDateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 28, weight: .heavy)
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.textColor = .white
        view.layer.cornerRadius = 10
        view.font = .systemFont(ofSize: 16, weight: .bold)
        view.backgroundColor = UIColor(red: 0.09957252358, green: 0.09957252358, blue: 0.09957252358, alpha: 0.6)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [saveButton, cancelButton, regDateLabel, lineView, textView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.height.equalTo(50)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
        regDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(36)
            make.top.equalTo(cancelButton.snp.bottom).offset(12)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(regDateLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(1)
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.leading.equalTo(lineView.snp.leading)
            make.trailing.equalTo(lineView.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-60)
        }
    }
}
