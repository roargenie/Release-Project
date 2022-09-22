

import UIKit



final class ThirdHomeDetailCustomHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CustomHeaderView"
    
    let styleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(styleImageView)
    }
    
    func setConstraints() {
        styleImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    
    
    
}
