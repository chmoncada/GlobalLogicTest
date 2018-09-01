//
//  DetailPresenterSpec.swift
//  GlobalLogicTestTests
//
//  Created by Charles Moncada on 01/09/18.
//  Copyright © 2018 Charles Moncada. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Alamofire

@testable import GlobalLogicTest

class DetailPresenterSpec: QuickSpec {

	override func spec() {

		describe("A Detail Presenter") {

			var sut: DetailViewPresenter!
			var mockView: MockDetailView!
			var laptop: Laptop!

			beforeEach {
				mockView = MockDetailView()
				laptop = Laptop(title: "Laptop 01", description: "Es la laptop 1", image: "http//www.anyurl.com")
				sut = DetailViewPresenter(view: mockView, item: laptop)
			}

			context("when the view is loaded") {
				beforeEach {
					sut.onViewDidLoad()
				}
				it("should display the item") {
					expect(mockView.displayedItem).to(equal(laptop))
				}
			}

		}
	}
}

// MARK: - Mocks

extension DetailPresenterSpec {

	class MockDetailView: DetailView {

		private(set) var displayedItem: Laptop?
		func configure(with item: Laptop) {
			displayedItem = item
		}
	}
}
