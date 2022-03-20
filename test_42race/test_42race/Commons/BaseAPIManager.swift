//
//  BaseAPIManager.swift
//  test_42race
//
//  Created by Thien Huynh on 16/03/2022.
//

import Foundation
import Alamofire
import Moya

typealias ParametersDictionary = [String: Any]

/// Provides methods to perform requests over Moya
class BaseAPIManager<T: TargetType> {
	enum DataField: String {
		case none			// No nested data field
		case data = "data"	// Parse from "data" field
	}

	// MARK: - Properties

	/// Base URL built according to current environment
	static var basePath: String {
		return "https://api.yelp.com/v3/"
	}

	/// Moya provider object
	private lazy var provider: MoyaProvider<T> = {
		let authPlugin = AccessTokenPlugin(tokenClosure: { _ in
			"QKjvIOrIiAKXfEm0LtKvTEEkcgcx21mF_iiI23SY8ZZ2cgj54YnOMhRJKGzv-SyGx2FXI4xKj_bhQ5LUY3daYZmazb9FnS1IajHtAipjqbfYt3faNCvw1sjPIukyYnYx"
		})

		var plugins: [PluginType] = [authPlugin]

		#if DEBUG
		let loggerPlugin = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: [.verbose]))
		plugins.append(loggerPlugin)
		#endif

		let configuration = URLSessionConfiguration.default

		var headers: [String: String] = HTTPHeaders.default.dictionary
		configuration.headers = HTTPHeaders(headers)

		let interceptor = APIRequestRetrier(session: self.session)

		let session = Moya.Session(configuration: configuration, startRequestsImmediately: false, interceptor: interceptor)
		return MoyaProvider<T>(stubClosure: self.stubClosure, session: session, plugins: plugins)
	}()

	let session: Session
	private let stubClosure: MoyaProvider<T>.StubClosure

	init(session: Session,
		 stubClosure: @escaping MoyaProvider<T>.StubClosure = MoyaProvider.neverStub) {
		self.stubClosure = stubClosure
		self.session = session
	}
}

// MARK: - request APIs
extension BaseAPIManager {
	/// Handle request API with completion block
	@discardableResult
	func request<Model: Decodable>(target: T,
								   type: Model.Type,
								   dataField: DataField = .data,
								   callbackQueue: DispatchQueue? = .none,
								   progress: ProgressBlock? = .none,
								   completion: @escaping (Result<Model, APIError>) -> Void) -> Moya.Cancellable {
		return provider.request(target, callbackQueue: callbackQueue, progress: progress) { result in
			let result: Result<Model, APIError> = BaseAPIManager.mapResult(result, dataField: dataField)
			completion(result)
		}
	}
}

// MARK: - Helper methods

extension BaseAPIManager {
	/// Maps default Moya result type 'Result<Response, MoyaError>' to concrete decodable 'Result<DecodableModel, APIError>'
	/// by parsing BackendError formats from either success or faulure response if needed, and by decoding response data
	/// to provided Decodable type
	private static func mapResult<T: Decodable>(_ result: Result<Response, MoyaError>, dataField: DataField) -> Result<T, APIError> {
		switch result {
		case let .success(response):
			do {
				let model: T = try Self.mapResponse(response, dataField: dataField)
				return .success(model)
			} catch {
				return .failure(mapError(error))
			}
		case let .failure(error):
			return .failure(mapError(error))
		}
	}

	/// Map Error => APIError
	private static func mapError(_ error: Error) -> APIError {
		switch error {
		case let error as APIError:
			return error
		case let error as MoyaError:
			if let response = error.response {
				debugPrint("Curl (mapError): \(response.request?.curl() ?? "no request")")
				return decodeBackendError(data: response.data, statusCode: response.statusCode)
			}
			return .moya(error)
		default:
			return .unknown(error)
		}
	}

	/// Maps default Moya Response to concrete decodable Model
	/// by parsing BackendError formats from either success or faulure response if needed, and by decoding response data
	/// to provided Decodable type
	private static func mapResponse<T: Decodable>(_ response: Response, dataField: DataField) throws -> T {
		debugPrint("Curl: \(response.request?.curl() ?? "no request")")

		// Check statusCode in range 200 - 206 This mean success
		if 200 ... 206 ~= response.statusCode {
			do {
				// For EmptyModel
				if T.self == EmptyResponseModel.self {
					return EmptyResponseModel() as! T
				}

				let object = try JSONSerialization.jsonObject(with: response.data, options: [])

				// Check dictionary type
				guard let dict = object as? [String: Any] else {
					throw APIError.decoding(DecodingError(message: "Failed to decode object (reponse is not dictionary type)"))
				}

				// Check data field in dictionary type
				let pathData: Any?
				switch dataField {
				case .none:
					pathData = dict
				case .data:
					pathData = dict[dataField.rawValue]
				}
				guard let dataJson = pathData else {
					throw APIError.decoding(DecodingError(message: "Failed to decode object (no data field)"))
				}

				return try T(from: dataJson)
			} catch {
				throw APIError.decoding(error)
			}
		} else {
			throw decodeBackendError(data: response.data, statusCode: response.statusCode)
		}
	}

	/// Decode backend error
	private static func decodeBackendError(data: Data, statusCode: Int) -> APIError {
		do {
			let error = try BackendError(from: data)
			return .backend(error)
		} catch {
			return .decoding(error)
		}
	}
}
