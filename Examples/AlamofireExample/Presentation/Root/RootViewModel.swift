//Copyright Hitchhiker© 2017. All rights reserved.

import Foundation
import RxRequester

final class RootViewModel: ViewModelProtocol {
    var rxRequester: RxRequester!

    public init(rxRequester: RxRequester) {
        self.rxRequester = rxRequester
    }

}
