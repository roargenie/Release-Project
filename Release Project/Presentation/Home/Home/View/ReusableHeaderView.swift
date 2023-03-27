

import UIKit


final class ReusableHeaderView: UICollectionReusableView {
    
    static let identifier = "ReusableHeaderView"
    
    let headerTitleLabel: UILabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(headerTitleLabel)
    }
    
    func setConstraints() {
        headerTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func setupView(text: String) {
        headerTitleLabel.text = text
    }
    
}






