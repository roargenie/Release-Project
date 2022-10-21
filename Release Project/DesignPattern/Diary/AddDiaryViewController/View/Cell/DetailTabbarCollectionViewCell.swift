

import UIKit



final class DetailTabbarCollectionViewCell: BaseCollectionViewCell {
    
    let categoryTagLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(categoryTagLabel)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    override func setConstraints() {
        categoryTagLabel.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(4)
        }
    }
    
    
}
