//
//  HostelWorldTestViewModel.swift
//  HostelWorldTest
//
//  Created by Gabriel on 04/12/24.
//

import Combine
import SwiftUI

class PropertyViewModel: ObservableObject {
    @Published var properties: [PropertyDetails] = []
    @Published var selectedProperty: PropertyDetails?

    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIService

    // Initializing using APIService directly
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    // Function to search properties
    func fetchProperties() {
        apiService.fetchProperties()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Erro ao carregar propriedades: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] properties in
                self?.properties = properties
            })
            .store(in: &cancellables)
    }

    // Function to search property details
    func fetchPropertyDetails(id: String) {
        apiService.fetchPropertyDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Erro ao carregar detalhes da propriedade: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] propertyDetails in
                self?.selectedProperty = propertyDetails
            })
            .store(in: &cancellables)
    }
}
