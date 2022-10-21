

import UIKit


final class DetailCollectionViewCell: BaseCollectionViewCell {

    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func configureUI() {
        [imageView].forEach { self.addSubview($0) }
    }

    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }


}






