import UIKit

extension UIView {
    private func addYAnimation(_ heartIcon: UIImageView, _ view: UIView) {
        let yAnimation = CABasicAnimation(keyPath: "position.y")
        yAnimation.delegate = ViewRemover(for: heartIcon)
        yAnimation.fromValue = heartIcon.frame.origin.y
        yAnimation.toValue = heartIcon.frame.origin.y - view.frame.midY - 100
        yAnimation.duration = 2
        yAnimation.fillMode = .forwards
        yAnimation.isRemovedOnCompletion = false
        heartIcon.layer.add(yAnimation, forKey: "yAnimation")
    }
    
    private func addScaleAnimation(_ heartIcon: UIImageView) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 1.0
        scaleAnimation.duration = 0.25
        scaleAnimation.isRemovedOnCompletion = false
        heartIcon.layer.add(scaleAnimation, forKey: "scaleAnimation")
    }
    
    private func addFadeAnimation(_ heartIcon: UIImageView) {
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1.0
        fadeAnimation.toValue = 0.0
        fadeAnimation.duration = 2
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        fadeAnimation.fillMode = .forwards
        fadeAnimation.isRemovedOnCompletion = false
        heartIcon.layer.add(fadeAnimation, forKey: "fadeAnimation")
    }
    
    private func addXAnimation(_ heartIcon: UIImageView, _ xSpace: CGFloat, _ randomNumber: CGFloat) {
        let xAnimation = CABasicAnimation(keyPath: "position.x")
        xAnimation.fromValue = heartIcon.frame.origin.x
        xAnimation.toValue = heartIcon.frame.origin.x + (xSpace * randomNumber)
        xAnimation.duration = 1
        xAnimation.fillMode = .forwards
        xAnimation.isRemovedOnCompletion = false
        heartIcon.layer.add(xAnimation, forKey: "xAnimation")
    }
    
    public func animateHeart(OnView view: UIView, withImage image: UIImage) {
        let relativeFrame = self.convert(self.frame, to: view)
        let heartIcon = UIImageView(frame: CGRect(x: frame.origin.x + 20, y: relativeFrame.origin.y - 50, width: 40, height: 40))
        heartIcon.contentMode = .scaleAspectFill
        if #available(iOS 13.0, *) {
            heartIcon.image = image.withTintColor(.random())
        } else {
            // Fallback on earlier versions
            heartIcon.image = image
        }
        view.addSubview(heartIcon)
        view.bringSubviewToFront(heartIcon)
        
        let xSpace = view.frame.maxX - self.frame.maxX
        let randomNumber = CGFloat.random(in: -0.5...1)
        
        addYAnimation(heartIcon, view)
        addScaleAnimation(heartIcon)
        addFadeAnimation(heartIcon)
        addXAnimation(heartIcon, xSpace, randomNumber)
    }
}

class ViewRemover: NSObject, CAAnimationDelegate {
    private weak var view: UIView?
    
    init(for view: UIView) {
        super.init()
        self.view = view
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        view?.removeFromSuperview()
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue:  .random(), alpha: 1.0)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
