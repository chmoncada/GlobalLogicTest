//
//  APIClient.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 31/08/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
	func getList(completion:@escaping (Result<[Laptop]>) -> Void) {
		Alamofire.request(APIRouter.list)
			.responseData { response in
				let decoder = JSONDecoder()
				let results: Result<[Laptop]> = decoder.decodeResponse(from: response)
				completion(results)
		}
	}
}

extension JSONDecoder {
	func decodeResponse<T: Decodable>(from response: DataResponse<Data>) -> Result<T> {
		guard response.error == nil else {
			return .failure(CustomError.networkError)
		}

		guard let responseData = response.data else {
			return .failure(CustomError.noDataFromServer)
		}

		do {
			let item = try decode(T.self, from: responseData)
			return .success(item)
		} catch {
			return .failure(CustomError.parsingError)
		}
	}
}

enum CustomError: Error, LocalizedError, CustomDebugStringConvertible {
	case networkError
	case noDataFromServer
	case parsingError

	var errorDescription: String? {
		switch self {
		case .networkError:
			return "Network Error"
		case .noDataFromServer:
			return "No Data From Server"
		case .parsingError:
			return "Error Parsing"
		}
	}

	var debugDescription: String {
		switch self {
		case .networkError:
			return "Network Error"
		case .noDataFromServer:
			return "No Data From Server"
		case .parsingError:
			return "Error Parsing"
		}
	}
}
