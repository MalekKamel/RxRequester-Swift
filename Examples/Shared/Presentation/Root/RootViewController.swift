//
// Created by Sha on 2019-02-16.
// Copyright (c) 2019 A. All rights reserved.
//
import UserNotifications
import UIKit


var rootViewController: RootViewController!

final class RootViewController: NavigationController, ViewControllerProtocol {
    var current: UIViewController?
    var vm: RootViewModel!
    var dataSource: PostsDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigate(vc: PostsBuilder.make(dataSource: dataSource), type: .push)
    }
}

extension RootViewController {
    enum NavigationType {
        case push
        case add
        case present
    }

    func navigate(vc: UIViewController, type: NavigationType, animated: Bool = true) {

        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical

        switch type {
        case .push:
            pushViewController(vc, animated: animated)
        case .add:
            addChild(vc)
        case .present:
            present(vc, animated: animated)

        }
        vc.view.frame = view.safeAreaLayoutGuide.layoutFrame
        view.addSubview(vc.view)

        current?.willMove(toParent: nil)
        current?.viewWillDisappear(true)

        vc.didMove(toParent: self)
        vc.viewWillAppear(true)

        current = vc
    }
}