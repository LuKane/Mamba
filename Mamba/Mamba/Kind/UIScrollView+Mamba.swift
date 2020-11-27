//
//  UIScrollView+Mamba.swift
//  Mamba
//
//  Created by LuKane on 2020/11/27.
//

import UIKit

enum ScrollViewMambaDirection {
    case top
    case bottom
    case left
    case right
}

extension UIScrollView {
    
    /// scrollview will scroll to top | bottom | left | right with animated
    /// - Parameters:
    ///   - direction: direction
    ///   - animated: animated
    /// - Returns: void
    func scroll(direction: ScrollViewMambaDirection, animated: Bool) -> Void {
        switch direction {
            case .top:
                scrollMambaToTop(animated: animated)
            case .bottom:
                scrollMambaToBottom(animated: animated)
            case .left:
                scrollMambaToLeft(animated: animated)
            case .right:
                scrollMambaToRight(animated: animated)
        }
    }
    
    private func scrollMambaToTop(animated: Bool) -> Void {
        var offSet = contentOffset
        offSet.y = -contentInset.top
        setContentOffset(offSet, animated: animated)
    }
    private func scrollMambaToBottom(animated: Bool) -> Void {
        var offSet = contentOffset
        offSet.y = contentSize.height - bounds.height + contentInset.bottom
        setContentOffset(offSet, animated: animated)
    }
    private func scrollMambaToLeft(animated: Bool) -> Void {
        var offSet = contentOffset
        offSet.x = -contentInset.left
        setContentOffset(offSet, animated: animated)
    }
    private func scrollMambaToRight(animated: Bool) -> Void {
        var offSet = contentOffset
        offSet.x = contentSize.width - bounds.width + contentInset.right
        setContentOffset(offSet, animated: animated)
    }
}
