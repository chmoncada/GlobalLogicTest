//
//  Laptop.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 31/08/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import Foundation

struct Laptop: Codable {
	let title: String
	let description: String
	let image: String?
}

extension Laptop {
	var imageURL: URL? {
		guard let image = image else { return nil }
		return URL(string: image)
	}
}
