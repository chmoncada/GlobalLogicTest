//
//  ListViewBuilder.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 31/08/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import UIKit

class ListViewBuilder {

	func makeScene() -> ListViewController {

		let listViewController = ListViewController()
		let presenter = ListViewPresenter(view: listViewController)

		presenter.showDetail = { item in
			print("debo mostrar el detalle de \(item)")
		}

		listViewController.presenter = presenter
		return listViewController
	}
}
