//
//  RootTabBar.swift
//  CenterTabBarItem
//
//  Created by GNComms on 2022/02/02.
//

import UIKit

class RootTabBar: UITabBar {
    private var middleButton = UIButton()
    private var shapeLayer: CALayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMiddleButton()
    }

    /// 제곱근 함수: sqrt()
    /// hitTest 설명 글: https://zeddios.tistory.com/536
    /// 터치한 영역의 point를 받아 middleButton의 반지름 범위를 계산 후 UIView리턴
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHidden {
            return super.hitTest(point, with: event)
        }

        let from = point
        let to = middleButton.center

        /// pow(_ lhs: CGFloat, _ rhs: CGFloat)
        /// lhs의 rhs의 제곱값 pow(7,2) -> 49
        let xPow = pow(from.x - to.x, 2)
        let yPow = pow(from.y - to.y, 2)

        /// sqrt<T>(_ x: T)
        /// x의 제곱근 sqrt(49) -> 7
        let radius = sqrt(xPow + yPow)

        return radius <= 35 ? middleButton : super.hitTest(point, with: event)
    }
    
    override func draw(_ rect: CGRect) {
        addShape()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
    }

    func setupMiddleButton() {
        middleButton.frame.size = CGSize(width: 70, height: 70)
        middleButton.backgroundColor = .systemPink
        middleButton.layer.cornerRadius = 35
        middleButton.layer.borderWidth = 5
        middleButton.layer.borderColor = UIColor.white.cgColor
        middleButton.layer.masksToBounds = true
        middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        middleButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        addSubview(middleButton)
    }

    @objc func test() {
        print("my name is jeff")
    }
    
    // 커스텀 디자인 삽입
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = #colorLiteral(red: 0.9711386941, green: 0.9711386941, blue: 0.9711386941, alpha: 1)
        shapeLayer.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        shapeLayer.lineWidth = 0.5
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }

    /// UITabbar용 UIBezierPath 참고 자료
    ///https://stackoverflow.com/questions/59091488/swift-custom-tabbar-with-center-rounded-button
    func createPath() -> CGPath {
        let height: CGFloat = 55.0
        let path = UIBezierPath()
        let centerWidth = frame.width / 2
        print(centerWidth, centerWidth - height)
        path.move(to: CGPoint(x: 0, y: 0))

        path.addLine(to: CGPoint(x: centerWidth - height, y: 0))
        path.addCurve(to: CGPoint(x: centerWidth, y: -40),
                      controlPoint1: CGPoint(x: centerWidth - 40, y: 0),
                      controlPoint2: CGPoint(x: centerWidth - 35, y: -40))

        path.addCurve(to: CGPoint(x: centerWidth + height, y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: -40),
                      controlPoint2: CGPoint(x: centerWidth + 40, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()

        return path.cgPath
    }
}
