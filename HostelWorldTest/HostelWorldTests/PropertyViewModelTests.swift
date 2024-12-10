//
//  PropertyViewModelTests.swift
//  HostelWorldTestTests
//
//  Created by Gabriel on 09/12/24.
//

import XCTest
import Combine
@testable import HostelWorldTest

final class PropertyViewModelTests: XCTestCase {
    var viewModel: PropertyViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = PropertyViewModel()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        cancellables = nil
        super.tearDown()
    }

//    func testFetchPropertiesSuccess() {
//        // Arrange
//        mockAPIService.mockPropertiesResponse = .success(MockData.shared.mockProperties)
//
//        // Act
//        viewModel.fetchProperties()
//        viewModel.$properties
//            .sink { properties in
//                // Assert
//                XCTAssertEqual(properties.count, MockData.shared.mockProperties.count)
//                XCTAssertEqual(properties.first?.id, MockData.shared.mockProperties.first?.id)
//            }
//            .store(in: &cancellables)
//    }

    func testFetchPropertiesFailure() {
        // Arrange
        mockAPIService.mockPropertiesResponse = .failure(URLError(.badServerResponse))

        // Act
        viewModel.fetchProperties()
        viewModel.$properties
            .sink { properties in
                // Assert
                XCTAssertTrue(properties.isEmpty)
            }
            .store(in: &cancellables)
    }

    func testFetchPropertyDetailsSuccess() {
        // Arrange
        let mockProperty = MockData.shared.mockPropertyDetails
        mockAPIService.mockPropertyDetailsResponse = .success(mockProperty)

        // Act
        viewModel.fetchPropertyDetails(id: mockProperty.id)
        
        // Observe selectedProperty and verify its details
        viewModel.$selectedProperty
            .sink { selectedProperty in
                // Assert
                if let selectedProperty = selectedProperty {
                    XCTAssertEqual(selectedProperty.id, mockProperty.id)
                    XCTAssertEqual(selectedProperty.name, mockProperty.name)
                }
            }
            .store(in: &cancellables)
    }

    func testFetchPropertyDetailsFailure() {
        // Arrange
        mockAPIService.mockPropertyDetailsResponse = .failure(URLError(.badServerResponse))

        // Act
        viewModel.fetchPropertyDetails(id: "invalid_id")
        viewModel.$selectedProperty
            .sink { selectedProperty in
                // Assert
                XCTAssertNil(selectedProperty)
            }
            .store(in: &cancellables)
    }
}


