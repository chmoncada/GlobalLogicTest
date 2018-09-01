//
//  DetailViewController.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 01/09/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import UIKit
import AlamofireImage

protocol DetailView: class {
	func configure(with item: Laptop)
}

class DetailViewController: UIViewController, DetailView {

	var presenter: DetailViewPresenter!
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var descriptionTextView: UITextView!

	override func viewDidLoad() {
        super.viewDidLoad()
		presenter.onViewDidLoad()
    }

	func configure(with item: Laptop) {
		title = item.title
		descriptionTextView.text = item.description

		if let url = item.imageURL {
			imageView.af_setImage(withURL: url)
		}

	}

}
