//
//  APIService.swift
//  HostelWorldTest
//
//  Created by Gabriel on 05/12/24.
//

import Foundation
import Combine

enum Environment {
    case mock
    case production
}

class APIService {
    static var shared: APIService = APIService()
    private let baseURL = "http://private-anon-0bc7fcc07f-practical3.apiary-mock.com"
    var environment: Environment = .production

    init() {}

    func fetchProperties() -> AnyPublisher<[PropertyDetails], Error> {
        switch environment {
        case .mock:
            return Just(MockData.shared.mockProperties) // Using mock data
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .production:
            guard let url = URL(string: "\(baseURL)/cities/1530/properties/") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { output in
                    guard let httpResponse = output.response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        throw URLError(.badServerResponse)
                    }
                    return output.data
                }
                .decode(type: PropertiesResponse.self, decoder: JSONDecoder())
                .map { $0.properties }
                .eraseToAnyPublisher()
        }
    }

    func fetchPropertyDetails(id: String) -> AnyPublisher<PropertyDetails, Error> {
        switch environment {
        case .mock:
            return Just(MockData.shared.mockPropertyDetails)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .production:
            guard let url = URL(string: "\(baseURL)/properties/\(id)") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { output in
                    guard let httpResponse = output.response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        throw URLError(.badServerResponse)
                    }
                    return output.data
                }
                .decode(type: PropertyDetails.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    }
}






