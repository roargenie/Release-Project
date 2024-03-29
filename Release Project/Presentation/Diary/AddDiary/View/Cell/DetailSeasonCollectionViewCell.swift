

import UIKit



final class DetailSeasonCollectionViewCell: BaseCollectionViewCell {
    
    let seasonTagLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        self.addSubview(seasonTagLabel)
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
    }
    
    override func setConstraints() {
        seasonTagLabel.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide).inset(4)
        }
    }
     
    
}
