//
//  MockAPIService.swift
//  HostelWorldTest
//
//  Created by Gabriel on 09/12/24.
//

import Combine
import Foundation

final class MockAPIService {
    var mockPropertiesResponse: Result<[PropertyDetails], Error>?
    var mockPropertyDetailsResponse: Result<PropertyDetails, Error>?

    // Fetch properties
    func fetchProperties() -> AnyPublisher<[PropertyDetails], Error> {
        if let response = mockPropertiesResponse {
            return response.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
    }

    // Fetch property details
    func fetchPropertyDetails(id: String) -> AnyPublisher<PropertyDetails, Error> {
        if let response = mockPropertyDetailsResponse {
            return response.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
    }
}






