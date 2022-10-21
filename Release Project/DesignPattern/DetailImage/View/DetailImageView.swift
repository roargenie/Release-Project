

import UIKit


final class DetailImageView: BaseView {
    
    let detailImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .black
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.addSubview(detailImageView)
        view.zoomScale = 1.0
        view.minimumZoomScale = 1.0
        view.maximumZoomScale = 2.0
        return view
    }()
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [scrollView, cancelButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        detailImageView.snp.makeConstraints { make in
            make.center.equalTo(scrollView.snp.center)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        cancelButton.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.width.height.equalTo(60)
        }
    }
    
}
