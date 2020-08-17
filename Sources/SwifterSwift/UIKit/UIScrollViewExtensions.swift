//
//  UIScrollViewExtensions.swift
//  SwifterSwift
//
//  Created by camila oliveira on 22/04/18.
//  Copyright © 2018 SwifterSwift
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIScrollView {

    /// SwifterSwift: Takes a snapshot of an entire ScrollView
    ///
    ///    AnySubclassOfUIScroolView().snapshot
    ///    UITableView().snapshot
    ///
    /// - Returns: Snapshot as UIimage for rendered ScrollView
    var snapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = frame
        frame = CGRect(origin: frame.origin, size: contentSize)
        layer.render(in: context)
        frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// SwifterSwift: The currently visible region of the scroll view.
    var visibleRect: CGRect {
        let contentWidth = contentSize.width - contentOffset.x
        let contentHeight = contentSize.height - contentOffset.y
        return CGRect(origin: contentOffset,
                      size: CGSize(width: min(min(bounds.size.width, contentSize.width), contentWidth),
                                   height: min(min(bounds.size.height, contentSize.height), contentHeight)))
    }

}

extension UIScrollView {

    /// SwifterSwift: Scroll to the top-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToTop(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: -contentInset.top), animated: animated)
    }

    /// SwifterSwift: Scroll to the left-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToLeft(animated: Bool = true) {
        setContentOffset(CGPoint(x: -contentInset.left, y: contentOffset.y), animated: animated)
    }

    /// SwifterSwift: Scroll to the bottom-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToBottom(animated: Bool = true) {
        setContentOffset(CGPoint(x: contentOffset.x, y: max(0, contentSize.height - bounds.height) + contentInset.bottom), animated: animated)
    }

    /// SwifterSwift: Scroll to the right-most content offset.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollToRight(animated: Bool = true) {
        setContentOffset(CGPoint(x: max(0, contentSize.width - bounds.width) + contentInset.right, y: contentOffset.y), animated: animated)
    }

    /// SwifterSwift: Scroll up one length of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollUp(animated: Bool = true) {
        let minY = -contentInset.top
        let y = max(minY, contentOffset.y - bounds.height)
        if isPagingEnabled {
            let page = max(0, ((y + contentInset.top) / bounds.height).rounded(.down))
            setContentOffset(CGPoint(x: contentOffset.x, y: max(minY, page * bounds.height - contentInset.top)), animated: animated)
        } else {
            setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
        }
    }

    /// SwifterSwift: Scroll left one width of the scroll view.
    /// If `isPagingEnabled` is `true`, the previous page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollLeft(animated: Bool = true) {
        let minX = -contentInset.left
        let x = max(minX, contentOffset.x - bounds.width)
        if isPagingEnabled {
            let page = ((x + contentInset.left) / bounds.width).rounded(.down)
            setContentOffset(CGPoint(x: max(minX, page * bounds.width - contentInset.left), y: contentOffset.y), animated: animated)
        } else {
            setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
        }
    }

    /// SwifterSwift: Scroll down one length of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollDown(animated: Bool = true) {
        let maxY = max(0, contentSize.height - bounds.height) + contentInset.bottom
        let y = min(maxY, contentOffset.y + bounds.height)
        if isPagingEnabled {
            let page = ((y + contentInset.top) / bounds.height).rounded(.down)
            setContentOffset(CGPoint(x: contentOffset.x, y: min(maxY, page * bounds.height - contentInset.top)), animated: animated)
        } else {
            setContentOffset(CGPoint(x: contentOffset.x, y: y), animated: animated)
        }
    }

    /// SwifterSwift: Scroll right one length of the scroll view.
    /// If `isPagingEnabled` is `true`, the next page location is used.
    /// - Parameter animated: `true` to animate the transition at a constant velocity to the new offset, `false` to make the transition immediate.
    func scrollRight(animated: Bool = true) {
        let maxX = max(0, contentSize.width - bounds.width) + contentInset.right
        let x = min(maxX, contentOffset.x + bounds.width)
        if isPagingEnabled {
            let page = ((x + contentInset.left) / bounds.width).rounded(.down)
            setContentOffset(CGPoint(x: min(maxX, page * bounds.width - contentInset.left), y: contentOffset.y), animated: animated)
        } else {
            setContentOffset(CGPoint(x: x, y: contentOffset.y), animated: animated)
        }
    }

}

#endif
