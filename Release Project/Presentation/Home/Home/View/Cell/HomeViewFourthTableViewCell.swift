

import UIKit



final class HomeViewFourthTableViewCell: BaseTableViewCell {
    
    let outerLabel: ProgressBarLabel = {
        let view = ProgressBarLabel()
        view.text = "아우터"
        return view
    }()
    
    let topLabel: ProgressBarLabel = {
        let view = ProgressBarLabel()
        view.text = "상의"
        return view
    }()
    
    let bottomLabel: ProgressBarLabel = {
        let view = ProgressBarLabel()
        view.text = "하의"
        return view
    }()
    
    let shoesLabel: ProgressBarLabel = {
        let view = ProgressBarLabel()
        view.text = "신발"
        return view
    }()
    
    let accLabel: ProgressBarLabel = {
        let view = ProgressBarLabel()
        view.text = "악세"
        return view
    }()
    
    let otherLabel: ProgressBarLabel = {
        let view = ProgressBarLabel()
        view.text = "기타"
        return view
    }()
    
    let outerPercent: ProgressBar = {
        let view = ProgressBar()
        return view
    }()
    
    let topPercent: ProgressBar = {
        let view = ProgressBar()
        return view
    }()
    
    let bottomPercent: ProgressBar = {
        let view = ProgressBar()
        return view
    }()
    
    lazy var firstStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [outerPercent, topPercent, bottomPercent])
        view.axis = .horizontal
        view.spacing = 20
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    let shoesPercent: ProgressBar = {
        let view = ProgressBar()
        return view
    }()
    
    let accPercent: ProgressBar = {
        let view = ProgressBar()
        return view
    }()
    
    let otherPercent: ProgressBar = {
        let view = ProgressBar()
        return view
    }()
    
    lazy var secondStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [shoesPercent, accPercent, otherPercent])
        view.axis = .horizontal
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [firstStackView, secondStackView, outerLabel, topLabel, bottomLabel, shoesLabel, accLabel, otherLabel].forEach { self.contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        firstStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).multipliedBy(0.5)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        secondStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).multipliedBy(1.5)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
        outerLabel.snp.makeConstraints { make in
            make.edges.equalTo(outerPercent.snp.edges).inset(12)
            make.height.equalTo(outerLabel.snp.width)
        }
        topLabel.snp.makeConstraints { make in
            make.edges.equalTo(topPercent.snp.edges).inset(12)
        }
        bottomLabel.snp.makeConstraints { make in
            make.edges.equalTo(bottomPercent.snp.edges).inset(12)
        }
        shoesLabel.snp.makeConstraints { make in
            make.edges.equalTo(shoesPercent.snp.edges).inset(12)
            make.height.equalTo(shoesLabel.snp.width)
        }
        accLabel.snp.makeConstraints { make in
            make.edges.equalTo(accPercent.snp.edges).inset(12)
        }
        otherLabel.snp.makeConstraints { make in
            make.edges.equalTo(otherPercent.snp.edges).inset(12)
        }
    }
    
}
