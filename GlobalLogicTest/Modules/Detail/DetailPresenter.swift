//
//  DetailPresenter.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 01/09/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import Foundation

class DetailViewPresenter {
	weak var view: DetailView?

	let item: Laptop

	init(view: DetailView, item: Laptop) {
		self.view = view
		self.item = item
	}

	func onViewDidLoad() {
		view?.configure(with: item)
	}

}
