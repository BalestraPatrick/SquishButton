//
//  SquishButton
//  Released under the MIT license.
//  http://github.com/BalestraPatrick/SquishButton
//
//  Created by Patrick Balestra on 04/08/2017.
//  Copyright (c) 2017 Patrick Balestra. All rights reserved.
//

import UIKit

open class SquishButton: UIButton {

    // MARK: Public properties

    /// The number of pixels to scale the inner rectangle.
    open var scaling = CGFloat(10)

    /// The duration of the animation when the button is in the highlighted state.
    open var animationDuration = 0.15

    /// The color of the inner rectangle.
    open var color = UIColor(red: 244.0/255.0, green: 51.0/255.0, blue: 50.0/255.0, alpha: 1.0)

    /// The inset between the outer border and inner rectangle.
    open var innerInset = CGFloat(5) {
        didSet {
            innerShape.path = UIBezierPath(roundedRect: bounds.insetBy(dx: innerInset, dy: innerInset), cornerRadius: bounds.height / 2).cgPath
        }
    }

    // MARK: Overriden properties

    override open var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else { return }
            animateHighlight()
        }
    }

    open override var frame: CGRect {
        didSet {
            setUp()
        }
    }

    // MARK: Private properties

    private var innerShape: CAShapeLayer!
    private let scaleX = "scale.x"
    private let scaleY = "scale.y"

    // MARK: Public initializers

    init() {
        super.init(frame: .zero)
        setUp()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func setUp() {
        setTitleColor(.white, for: .normal)
        setTitleColor(.clear, for: .highlighted)

        layer.cornerRadius = bounds.height / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor

        innerShape = CAShapeLayer()
        innerShape.frame = bounds
        innerShape.path = UIBezierPath(roundedRect: bounds.insetBy(dx: innerInset, dy: innerInset), cornerRadius: bounds.height / 2).cgPath
        innerShape.fillColor = color.cgColor
        layer.addSublayer(innerShape)
    }

    func animateHighlight() {

        // Scale by the same absolute amount on each side for equal spacing with the outer border.
        let scalingFactorX = 1 - (scaling / innerShape.bounds.width)
        let scalingFactorY = 1 - (scaling / innerShape.bounds.height)

        let animationX = CABasicAnimation(keyPath: "transform.scale.x")
        animationX.duration = animationDuration
        animationX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let animationY = CABasicAnimation(keyPath: "transform.scale.y")
        animationY.duration = animationDuration
        animationY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        if isHighlighted {
            animationX.toValue = scalingFactorX
            animationX.isRemovedOnCompletion = false
            animationX.fillMode = kCAFillModeForwards
            innerShape.add(animationX, forKey: scaleX)

            animationY.toValue = scalingFactorY
            animationY.isRemovedOnCompletion = false
            animationY.fillMode = kCAFillModeForwards
            innerShape.add(animationY, forKey: scaleY)
        } else {
            animationX.fromValue = scalingFactorX
            animationX.toValue = 1.0
            innerShape.add(animationX, forKey: scaleX)

            animationY.fromValue = scalingFactorY
            animationY.toValue = 1.0
            innerShape.add(animationY, forKey: scaleY)
        }
    }
}
