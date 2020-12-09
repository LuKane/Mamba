//
//  UIView+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/27.
//

import UIKit

extension UIView {
    /// Shortcut frame.origin.x
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var fra = frame
            fra.origin.x = newValue
            frame = fra
        }
    }
    /// Shortcut  frame.origin.y
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var fra = frame
            fra.origin.y = newValue
            frame = fra
        }
    }
    /// Shortcut frame.origin.x + frame.size.width
    public var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            var fra = frame
            fra.origin.x = newValue - fra.size.width
            frame = fra
        }
    }
    /// Shortcut frame.origin.y + frame.size.height
    public var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            var fra = frame
            fra.origin.y = newValue - fra.size.height
            frame = fra
        }
    }
    /// Shortcut frame.size.width
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    /// Shortcut frame.size.height
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    /// Shortcut center
    public var center: CGPoint {
        get {
            return CGPoint(x: frame.origin.x + frame.size.width * 0.5, y: frame.origin.y + frame.size.height * 0.5)
        }
        set {
            var fra = frame
            fra.origin.x = newValue.x - fra.size.width * 0.5
            fra.origin.y = newValue.y - fra.size.height * 0.5
            frame = fra
        }
    }
    /// Shortcut centerX
    public var centerX: CGFloat {
        get {
            return frame.origin.x + frame.size.width * 0.5
        }
        set {
            var fra = frame
            fra.origin.x = newValue - fra.size.width * 0.5
            frame = fra
        }
    }
    /// Shortcut centerY
    public var centerY: CGFloat {
        get {
            return frame.origin.y + frame.size.height * 0.5
        }
        set {
            var fra = frame
            fra.origin.y = newValue - fra.size.height * 0.5
            frame = fra
        }
    }
    /// Shortcut origin
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            var fra = frame
            fra.origin = newValue
            frame = fra
        }
    }
    /// Shortcut size
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            var fra = frame
            fra.size = newValue
            frame = fra
        }
    }
    
    /// remove subviews
    public func removeAllSubViews() -> Void {
        for obj in 0..<subviews.count {
            subviews[obj].removeFromSuperview()
        }
    }
    /// get current responder controller
    public func currentViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let vc = nextResponder as? UIViewController {
                return vc
            }
        } while nextResponder != nil
        
        return nil
    }
    
    /// layer shadow
    /// - Parameters:
    ///   - color: color
    ///   - offset: offset ,Default (0,-3)
    ///   - radius: blur radius used to create the shadow. Defaults to 3. Animatable.
    /// - Returns: void
    public func layerShadow(color: UIColor, offset: CGSize, radius: CGFloat) -> Void {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    /// Get current UIScreen UI of SnapShot
    /// - Returns: image
    public func snapShotImage() -> UIImage {
        let render = UIGraphicsImageRenderer.init(bounds: bounds)
        return render.image { (context) in
            layer.render(in: context.cgContext)
        }
    }
    
    /********************************** * == corner == * ****************************************/
    
    /// add corners [view.corners(corners: [UIRectCorner.topLeft,UIRectCorner.topRight], cornerRadius: 10)]
    /// - Parameters:
    ///   - corners: corners
    ///   - cornerRadius: radius
    /// - Returns: void
    public func corners(corners: UIRectCorner, cornerRadius: CGFloat) -> Void {
        let maskPath : UIBezierPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer : CAShapeLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path  = maskPath.cgPath
        layer.mask      = maskLayer
    }
    /********************************** * == corner == * ****************************************/
}
