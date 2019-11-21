//Copyright Hitchhiker© 2017. All rights reserved.

import UIKit
import RxRequester

struct RootBuilder {

    static func make() -> RootViewController {
        let storyboard = UIStoryboard(name: "Root", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! RootViewController
        vc.vm = RootViewModel(rxRequester: RxRequester(presentable: vc))
        return vc
    }

}

