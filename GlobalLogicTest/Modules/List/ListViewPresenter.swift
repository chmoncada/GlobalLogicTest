//
//  ListViewPresenter.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 31/08/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import Foundation

class ListViewPresenter {
	weak var view: ListView?
	private let apiClient: APIClient
	var showDetail: ((Laptop) -> Void)?

	private var items: [Laptop] = [] {
		didSet {
			view?.displayLaptops(items)
		}
	}

	init(view: ListView, apiClient: APIClient = APIClient()) {
		self.view = view
		self.apiClient = apiClient
	}

	func onViewDidLoad() {

		view?.startLoading()

		apiClient.getList { [weak self] result in
			switch result {
			case .success(let laptops):
				self?.view?.stopLoading()
				self?.items = laptops
			case .failure(let error):
				self?.view?.display(error)
			}
		}
	}

	func onItemSelected(at index: Int) {

		guard index < items.count else {
			fatalError("Selected index does not contain a Item")
		}

		let item = items[index]
		showDetail?(item)
	}
}
