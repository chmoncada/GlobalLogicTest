//
//  APIRouter.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 31/08/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
	var method: HTTPMethod { get }
	var path: String { get }
	var parameters: Parameters? { get }
}

enum APIRouter: APIConfiguration {

	case list

//	MARK: - URLRequestConvertible
	var method: HTTPMethod {
		switch self {
		case .list:
			return .get
		}
	}

	var path: String {
		switch self {
		case .list:
			return "/list"
		}
	}

	var parameters: Parameters? {
		switch self {
		case .list:
			return nil
		}
	}

//	MARK: - URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		let url = try Constants.baseURL.asURL()

		var urlRequest = URLRequest(url: url.appendingPathComponent(path))

		// HTTP Method
		urlRequest.httpMethod = method.rawValue

		// Common Headers
		urlRequest.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.acceptType)
		urlRequest.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.contentType)

		// Parameters
		if let parameters = parameters {
			do {
				urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
			} catch {
				throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
			}
		}

		return urlRequest
	}
}
