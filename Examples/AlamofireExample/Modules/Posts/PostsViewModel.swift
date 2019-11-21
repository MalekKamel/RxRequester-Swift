//Copyright HitchHiker© 2017. All rights reserved.

import Foundation
import RxSwift
import RxRequester

final class PostsViewModel: ViewModelProtocol {
    var rxRequester: RxRequester!
    private var postsRepository: PostsRepository!

    init(rxRequester: RxRequester, postsRepository: PostsRepository) {
        self.rxRequester = rxRequester
        self.postsRepository = postsRepository
    }

     func posts() -> Single<[Post]> {
        rxRequester.request { [weak self] in
            self!.postsRepository.all().map { $0.toPresent() }
        }
    }

}


