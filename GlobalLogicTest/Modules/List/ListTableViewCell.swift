//
//  ListTableViewCell.swift
//  GlobalLogicTest
//
//  Created by Charles Moncada on 01/09/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import UIKit
import AlamofireImage

class ListTableViewCell: UITableViewCell {

	@IBOutlet weak var photoView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!


	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configure(with item: Laptop) {
		titleLabel.text = item.title
		descriptionLabel.text = item.description

		//imageView?.image = UIImage(named: "100x100")

		if let url = item.imageURL {
			photoView.af_setImage(withURL: url, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: false)
		}
	}

	override func prepareForReuse() {
		photoView.image = UIImage(named: "100x100")
		textLabel?.text = nil
		descriptionLabel.text = nil
	}
    
}
