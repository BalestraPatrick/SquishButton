import UIKit

@IBDesignable
class SquishButton: UIButton {

    // MARK: Public properties

    var scaling = CGFloat(10)

    var borderWidth = CGFloat(2) {
        didSet {
            setNeedsDisplay()
        }
    }

    var animationDuration = 0.15

    var color = UIColor(red: 244.0/255.0, green: 51.0/255.0, blue: 50.0/255.0, alpha: 1.0)

    var innerShape: CAShapeLayer!

    // MARK: Overriden properties

    override var isHighlighted: Bool {
        didSet {
            guard oldValue != isHighlighted else { return }
            animateHighlight()
        }
    }

    // MARK: Private properties

    private let scaleX = "scale.x"
    private let scaleY = "scale.y"

    override func draw(_ rect: CGRect) {
        let outerLine = UIBezierPath(roundedRect: bounds.insetBy(dx: borderWidth / 2, dy: borderWidth / 2), cornerRadius: bounds.height / 2)
        outerLine.lineWidth = borderWidth
        UIColor.white.setStroke()
        outerLine.stroke()
    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func setUp() {
        // TODO: remove debug title
        setTitle("HOLD TO RECORD", for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.clear, for: .highlighted)

        innerShape = CAShapeLayer()
        innerShape.frame = bounds
        innerShape.path = UIBezierPath(roundedRect: bounds.insetBy(dx: 5, dy: 5), cornerRadius: bounds.height / 2).cgPath
        innerShape.fillColor = color.cgColor
        layer.addSublayer(innerShape)
    }

    func animateHighlight() {
        // Scale by the same absolute amount on each side for equal spacing between the outer border.
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
