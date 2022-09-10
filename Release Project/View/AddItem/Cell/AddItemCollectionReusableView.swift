

import UIKit
import Floaty


final class AddItemCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "AddItemCollectionReusableView"
    
//    let floaty: Floaty = {
//        let view = Floaty()
//        view.addItem(icon: UIImage(systemName: "list.bullet.circle"))
//        return view
//    }()
//
//    let itemCountLabel: UILabel = {
//        let view = UILabel()
//        view.text = "5 items"
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
//        [floaty, itemCountLabel].forEach { self.addSubview($0) }
    }
    
    func setConstraints() {
//        floaty.snp.makeConstraints { make in
//            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
//            make.centerX.equalTo(self.snp.centerX)
//            make.width.height.equalTo(40)
//        }
//        itemCountLabel.snp.makeConstraints { make in
//            make.top.equalTo(floaty.snp.bottom).offset(10)
//            make.height.equalTo(20)
//            make.centerX.equalTo(self.snp.centerX)
//        }
    }
    
}
