//
//  ListViewBuilder.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 31/08/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import UIKit

class ListViewBuilder {

	private let detailBuilder: DetailBuilder

	init(detailBuilder: DetailBuilder = DetailBuilder()) {
		self.detailBuilder = detailBuilder
	}

	func makeScene() -> ListViewController {

		let listViewController = ListViewController()
		let presenter = ListViewPresenter(view: listViewController)

		presenter.showDetail = { [detailBuilder] item in
			let detailVC = detailBuilder.makeScene(with: item)
			listViewController.show(detailVC, sender: nil)
		}

		listViewController.presenter = presenter
		return listViewController
	}
}
