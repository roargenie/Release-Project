

import UIKit


final class FirstAddItemDetailCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "FirstAddItemDetailCollectionReusableView"
    
    let headerLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 24, weight: .heavy)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(headerLabel)
    }
    
    func setConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    
    
    
    
}
