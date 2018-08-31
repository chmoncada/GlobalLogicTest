//
//  Constants.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 31/08/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import Foundation

enum Constants {
	static let baseURL = "http://private-f0eea-mobilegllatam.apiary-mock.com"
}

enum HTTPHeaderField {
	static let authentication = "Authorization"
	static let contentType = "Content-Type"
	static let acceptType = "Accept"
	static let acceptEncoding = "Accept-Encoding"
}

enum ContentType {
	static let json = "application/json"
}
