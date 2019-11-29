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
        let options = RequestOptions.Builder()
                .showLoading(true)
                .hideLoading(true)
                .inlineErrorHandling { error in false }
                .doOnError { error in }
                .observeOnScheduler(MainScheduler.instance)
                .subscribeOnScheduler(ConcurrentDispatchQueueScheduler(qos: .background))
                .build()
        return rxRequester.request(options: options) { [weak self] in
            self!.postsRepository.all().map { ListMapper(PostMapper()).map($0) }
        }
    }

}


