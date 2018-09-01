//
//  ListViewController.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 01/09/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import UIKit

protocol ListView: class {
	func startLoading()
	func stopLoading()
	func displayLaptops(_ laptops: [Laptop])
	func display(_ error: Error)
}

class ListViewController: UIViewController {
	
	@IBOutlet private weak var tableView: UITableView!
	var presenter: ListViewPresenter!

	private weak var loadingView: UIActivityIndicatorView?
	let cellIdentifier = "Cell"

	private var dataModel: [Laptop] = [] {
		didSet {
			tableView.reloadData()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "List"
		tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
		tableView.estimatedRowHeight = 120
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.alpha = 0
		presenter.onViewDidLoad()
	}

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataModel.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
		cell.configure(with: dataModel[indexPath.row])

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		presenter.onItemSelected(at: indexPath.row)
	}
}

extension ListViewController : ListView {
	private func setupLoadingViewIfNeeded() -> UIActivityIndicatorView {
		if let loadingView = loadingView {
			return loadingView
		} else {

			let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

			loadingView.color = .black
			loadingView.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(loadingView)
			loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

			self.loadingView = loadingView
			return loadingView

		}
	}

	func startLoading() {

		let loadingView = setupLoadingViewIfNeeded()
		loadingView.alpha = 0
		loadingView.startAnimating()

		UIView.animate(withDuration: 1, delay: 1, options: [], animations: { [weak loadingView] in
			loadingView?.alpha = 1
			}, completion: nil)

	}

	func stopLoading() {
		guard let loadingView = loadingView else { return }
		self.loadingView = nil

		UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: { [weak loadingView] in
			loadingView?.alpha = 0
			}, completion: { (completed) in
				loadingView.removeFromSuperview()
		})

	}

	func displayLaptops(_ laptops: [Laptop]) {
		//		self.movieCellModels = movieCellModels
		//		collectionView.reloadData()
		//		UIView.animate(withDuration: 0.3) { [weak self] in
		//			self?.collectionView.alpha = 1
		//		}
		dataModel = laptops
		UIView.animate(withDuration: 0.3) { [weak self] in
			self?.tableView.alpha = 1
		}

	}

	func display(_ error: Error) {

	}



}
