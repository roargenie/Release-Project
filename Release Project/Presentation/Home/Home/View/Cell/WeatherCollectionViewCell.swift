//
//  WeatherCollectionViewCell.swift
//  Release Project
//
//  Created by 이명진 on 2023/03/28.
//

import UIKit
import Then

final class WeatherCollectionViewCell: BaseCollectionViewCell {
    
    let weatherImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let tempLabel: UILabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 40, weight: .heavy)
    }
    
    let highestAndMinimumTempLabel: UILabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 13, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        [weatherImageView, highestAndMinimumTempLabel, tempLabel].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        weatherImageView.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-40)
        }
        tempLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(36)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(80)
        }
        highestAndMinimumTempLabel.snp.makeConstraints { make in
            make.leading.equalTo(tempLabel.snp.trailing).offset(4)
            make.bottom.equalTo(tempLabel.snp.bottom)
        }
    }
    
    func setupCell(_ item: WeatherItemModel) {
        tempLabel.text = "\(String(format: "%.0f", item.items.temp))°"
        highestAndMinimumTempLabel.text = "최고:\(String(format: "%.0f", item.items.temp_max))° / 최저:\(String(format: "%.0f", item.items.temp_min))°"
        weatherImageView.image = WeatherModel.getWeatherImage(id: item.items.id)
    }
    
}
