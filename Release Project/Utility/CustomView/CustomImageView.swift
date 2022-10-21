

import UIKit



class CustomImageView: UIImageView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .systemGray4
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
        }
        
    }
    
}
