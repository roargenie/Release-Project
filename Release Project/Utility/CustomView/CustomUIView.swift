

import UIKit


class CustomUIView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
}
