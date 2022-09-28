

import UIKit


class ProgressBarLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.backgroundColor = .black
        self.textColor = .white
        self.font = .systemFont(ofSize: 18, weight: .heavy)
        self.textAlignment = .center
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.width / 2
            self.clipsToBounds = true
        }
    }
}
