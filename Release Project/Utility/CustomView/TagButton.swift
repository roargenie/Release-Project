

import UIKit


class TagButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        layer.cornerRadius = 15
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 2
        setTitleColor(UIColor.black, for: .normal)
    }
    
    
}
