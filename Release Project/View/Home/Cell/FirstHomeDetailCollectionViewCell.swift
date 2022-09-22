

import UIKit


final class FirstHomeDetailCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
//    let itemLabel: UILabel = {
//        let view = UILabel()
//        view.textAlignment = .center
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        [imageView].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
//        itemLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom)
//            make.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
//        }
    }
    
}






