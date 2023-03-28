//
//  ItemRecommendCollectionViewCell.swift
//  Release Project
//
//  Created by 이명진 on 2023/03/28.
//

import UIKit

final class ItemRecommendCollectionViewCell: BaseCollectionViewCell {
    
    let recommendTitleLabel: UILabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .heavy)
        $0.backgroundColor = .black
//        $0.layer.cornerRadius = 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layer.cornerRadius = 20
    }
    
    override func configureUI() {
        addSubview(recommendTitleLabel)
    }
    
    override func setConstraints() {
        recommendTitleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
