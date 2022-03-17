//
//  APIError.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import Foundation
import Moya

/// Error code
enum APIErrorCode: Int {
	case unauthorized = 401
	case invalidCode = 400
}

/// Decoding error
struct DecodingError: LocalizedError {
    let message: String

    var errorDescription: String? {
        return message
    }
}

/// Backend error
struct BackendError: Decodable, LocalizedError {
    let message: String
    let statusCode: Int
	let errors: [String: [String]]?

    var errorDescription: String? {
		switch statusCode {
		// Validation error
		case 400..<499:
			return errors?.first?.value.first ?? message
		default:
			break
		}
        return message
    }

	enum CodingKeys: String, CodingKey {
		case message = "message"
		case statusCode = "status_code"
		case errors
	}
}

/// Possible error types that can be returned by APIManager
enum APIError: LocalizedError {
    case moya(MoyaError)
    case unknown(Error)
    case encoding(Error)
    case decoding(Error)
    case backend(BackendError)
    case invalid

    var errorDescription: String? {
        switch self {
        case let .moya(error): return error.localizedDescription
        case let .encoding(error): return error.localizedDescription
        case let .decoding(error): return error.localizedDescription
        case let .backend(error): return error.localizedDescription
        case let .unknown(error): return error.localizedDescription
        case .invalid: return "Something goes wrong, please, try again"
        }
    }

	var backendCode: Int? {
		switch self {
		case let .backend(error):
			return error.statusCode
		default:
			return nil
		}
	}
}
