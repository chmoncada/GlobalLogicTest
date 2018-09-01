//
//  ListPresenterSpec.swift
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

class ListViewPresenterSpec: QuickSpec {

	override func spec() {

		describe("A ListView Presenter") {

			var sut: ListViewPresenter!
			var mockView: MockListView!
			var mockRouter: MockRouter!
			var mockAPIClient: MockApiClient!

			beforeEach {
				mockView = MockListView()
				mockRouter = MockRouter()
				mockAPIClient = MockApiClient()
				sut = ListViewPresenter(view: mockView, apiClient: mockAPIClient)
				sut.showDetail = { _ in
					mockRouter.isShowingDetail = true
				}
			}

			context("when the view is loaded") {
				beforeEach {
					sut.onViewDidLoad()
				}
				it("should fetch the movies") {
					expect(mockAPIClient.isFetchGetList).to(beTrue())
					expect(mockView.isLoading).to(beTrue())
				}

				context("when the request fails") {
					var networkError: Error!
					beforeEach {
						networkError = CustomError.networkError
						mockAPIClient.completeFetching(with: .failure(networkError))
					}
					it("should display the error") {
						expect(mockView.displayedError).to(equal(networkError.localizedDescription))
					}
				}

				context("when is no data from Server") {
					var networkError: Error!
					beforeEach {
						networkError = CustomError.noDataFromServer
						mockAPIClient.completeFetching(with: .failure(networkError))
					}
					it("should display the error") {
						expect(mockView.displayedError).to(equal(networkError.localizedDescription))
					}
				}

				context("when the Parsing fails") {
					var networkError: Error!
					beforeEach {
						networkError = CustomError.parsingError
						mockAPIClient.completeFetching(with: .failure(networkError))
					}
					it("should display the error") {
						expect(mockView.displayedError).to(equal(networkError.localizedDescription))
					}
				}

				context("when the request completes successfully") {
					var laptop: Laptop!
					beforeEach {
						laptop = Laptop(title: "Laptop 01", description: "Es la laptop 1", image: "http//www.anyurl.com")
						mockAPIClient.completeFetching(with: .success([laptop]))
					}
					it("should display the movie cells") {
						expect(mockView.displayedLaptops).to(equal([laptop]))
					}

					context("when an item is selected") {
						beforeEach {
							sut.onItemSelected(at: 0)
						}
						it("should show movie details") {
							expect(mockRouter.isShowingDetail).to(beTrue())
						}
					}
				}

			}

		}
	}
}

// MARK: - Mockes

extension ListViewPresenterSpec {

	class MockListView: ListView {
		private(set) var isLoading = false
		func startLoading() {
			isLoading = true
		}

		func stopLoading() {
			isLoading = false
		}

		private(set) var displayedLaptops = [Laptop]()
		func displayLaptops(_ laptops: [Laptop]) {
			displayedLaptops = laptops
		}

		private(set) var displayedError: String?
		func display(_ error: Error) {
			displayedError = error.localizedDescription
		}
	}

	class MockRouter {
		var isShowingDetail = false
	}

	class MockApiClient: APIClient {

		private(set) var isFetchGetList = false
		private(set) var fetchGetListCompletion: ((Result<[Laptop]>) -> Void?)?

		override func getList(completion: @escaping (Result<[Laptop]>) -> Void) {
			isFetchGetList = true
			fetchGetListCompletion = completion
		}

		func completeFetching(with result: Result<[Laptop]>) {
			fetchGetListCompletion?(result)
			fetchGetListCompletion = nil
		}
	}
}
