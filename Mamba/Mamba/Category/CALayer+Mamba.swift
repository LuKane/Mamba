//
//  CALayer+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/25.
//

import UIKit

extension CALayer {
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
}
