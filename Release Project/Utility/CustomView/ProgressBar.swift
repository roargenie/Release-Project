

import UIKit


final class ProgressBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func progressBarDrawing(color: UIColor, value: CGFloat) {
        let viewCenter = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        let radius = (self.frame.width - 10) / 2
        let backPath = UIBezierPath(arcCenter: viewCenter,
                                    radius: radius,
                                    startAngle: -(0.5 * .pi),
                                    endAngle: (1.5 * .pi),
                                    clockwise: true)
        
        let backLayer = CAShapeLayer()
        backLayer.path = backPath.cgPath
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = UIColor.systemGray6.cgColor
        backLayer.lineWidth = 8
        backLayer.lineJoin = .round
        backLayer.lineCap = .round
        self.layer.addSublayer(backLayer)
        
        let path = UIBezierPath(arcCenter: viewCenter,
                                radius: radius,
                                startAngle: -(0.5 * .pi),
                                endAngle: (1.5 * .pi),
                                clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineJoin = .round
        layer.lineCap = .round
        layer.lineWidth = 8
        self.layer.addSublayer(layer)

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = value
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = 1.0
        layer.add(animation, forKey: "strokeEnd")
    }
}
