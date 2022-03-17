//
//  APIRequestRetrier.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import Foundation
import Alamofire
import Moya

/// A class, which represents the interceptor for Moya requests
/// Implementation of ```RequestRetrier``` protocol doesn't work for some reasons.
/// See https://github.com/Moya/Moya/issues/2096#issuecomment-782565397 for more details.
class APIRequestRetrier: Retrier {
    init(session: Session) {
        super.init { request, _, _, completion in
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401,
                  request.retryCount < 3
            else {
                completion(.doNotRetry)
                return
            }
        }
    }
}
