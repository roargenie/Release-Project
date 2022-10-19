

import UIKit


final class SettingCollectionViewCell: BaseCollectionViewCell {
    
//    let titleLabel: UILabel = {
//        let view = UILabel()
//        view.textAlignment = .center
//        view.font = .systemFont(ofSize: 15, weight: .bold)
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
//        [titleLabel].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
//        titleLabel.snp.makeConstraints { make in
//            make.edges.equalTo(self.safeAreaLayoutGuide).inset(4)
//        }
    }
    
}
