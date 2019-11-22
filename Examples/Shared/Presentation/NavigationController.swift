//Copyright HitchHiker© 2017. All rights reserved.

import UIKit

public class NavigationController: UINavigationController {
    public var lastViewController: UIViewController? = nil

    public override var childForStatusBarStyle: UIViewController? { viewControllers.last }
    public override var tabBarController: UITabBarController? { parent?.tabBarController }

    public required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        delegate = self
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        delegate = self
    }

    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        delegate = self
    }

    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

}

extension NavigationController: UINavigationControllerDelegate {

    public func navigationController(
            _ navigationController: UINavigationController,
            willShow viewController: UIViewController,
            animated: Bool
    ) {

        lastViewController?.viewWillDisappear(animated)
        viewController.viewWillAppear(animated)
        lastViewController = viewController
    }

    public func navigationController(
            _ navigationController: UINavigationController,
            didShow viewController: UIViewController,
            animated: Bool) {
        lastViewController?.viewDidDisappear(animated)
        viewController.viewDidAppear(animated)
        lastViewController = viewController
    }

}

