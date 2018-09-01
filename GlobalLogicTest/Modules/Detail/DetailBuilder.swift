//
//  DetailBuilder.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 01/09/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import UIKit

class DetailBuilder {

	func makeScene(with item: Laptop) -> DetailViewController {

		let detailViewController = DetailViewController()
		let presenter = DetailViewPresenter(view: detailViewController, item: item)

		detailViewController.presenter = presenter
		return detailViewController
	}
}
