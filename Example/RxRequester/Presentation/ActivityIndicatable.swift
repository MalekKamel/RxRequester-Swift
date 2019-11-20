//Copyright HitchHiker© 2017. All rights reserved.

import UIKit

public protocol ActivityIndicatable {
    var isLoading: Bool { get }
    func showLoading(show: Bool)
}

private let loadingViewTag = 4875618

extension ActivityIndicatable {

    var isLoading: Bool { rootViewController.view.viewWithTag(loadingViewTag) != nil }

    func showLoading(show: Bool) {

        if show {
            let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
            effectView.tag = loadingViewTag

            let indicator = UIActivityIndicatorView(style: .gray)
            indicator.hidesWhenStopped = true
            indicator.startAnimating()
            effectView.contentView.addSubview(indicator)
            indicator.bindFrameToSuperviewBounds()

            effectView.frame = rootViewController.view.frame
            rootViewController.view.addSubview(effectView)
            effectView.bindFrameToSuperviewBounds()

            return
        }

        while let effectView = rootViewController.view.viewWithTag(loadingViewTag) {
            effectView.removeFromSuperview()
        }

    }

}

extension UIView {
    /// Adds constraints to this `UIView` instances `superview` object to make sure this always has the same size as the superview.
    /// Please note that this has no effect if its `superview` is `nil` – add this `UIView` instance as a subview before calling this.
    func bindFrameToSuperviewBounds(insets: UIEdgeInsets = UIEdgeInsets.zero) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        superview.widthAnchor.constraint(equalTo: widthAnchor, constant: insets.left + insets.right).isActive = true
        superview.heightAnchor.constraint(equalTo: heightAnchor, constant: insets.top + insets.bottom).isActive = true
        superview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        superview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
