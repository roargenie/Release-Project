//
//  MonthOfWeekCollectionViewCell.swift
//  Release Project
//
//  Created by 이명진 on 2023/03/28.
//

import UIKit

final class MonthOfWeekCollectionViewCell: BaseCollectionViewCell {
    
    let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        layer.cornerRadius = 20
    }
    
    override func configureUI() {
        addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
