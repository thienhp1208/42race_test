//
//  BusinessTarget.swift
//  test_42race
//
//  Created by For Test Only on 17/03/2022.
//

import Moya

enum BusinessTarget {
    case searchBusinesses(ParametersDictionary)
    case getBusinessById(String)
}

extension BusinessTarget: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        return URL(string: BaseAPIManager<Self>.basePath)!
    }
    
    var path: String {
        switch self {
        case .searchBusinesses:
            return "businesses/search"
        case .getBusinessById(let id):
            return "businesses/\(id)"
        }
    }
    
    var method: Method {
        switch self {
        case .searchBusinesses, .getBusinessById:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchBusinesses(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getBusinessById:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var authorizationType: AuthorizationType? {
        return .bearer
    }
}
