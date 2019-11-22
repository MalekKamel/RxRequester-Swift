//
//  AlamofireDataSource.swift
//
//
//  Created by mac on 11/22/19.
//

import RxSwift
import Alamofire

class AlamofireDataSource: PostsDataSource {

    func all() -> Single<[PostResponse]> {
        Single.create(subscribe: { single in
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/101") else {
                let error = NSError (
                        domain: "Alamofire Error",
                        code: 100,
                        userInfo: [NSLocalizedDescriptionKey: "Can't create URL"])
                single(.error(error))
                return Disposables.create()
            }

            Alamofire.request(url,
                            method: .get)
                    .debugLog()
                    .validate()
                    .responseJSON { response in
                        guard response.result.isSuccess else {
                            single(.error(response.result.error!))
                            return
                        }

                        do {
                            let posts = try JSONDecoder().decode([PostResponse].self, from: response.data! )
                            return single(.success(posts))
                        } catch let e {
                            return single(.error(e))
                        }
                    }

            return Disposables.create()
        })
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}
