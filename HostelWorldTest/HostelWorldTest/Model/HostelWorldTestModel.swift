//
//  HostelWorldTestModel.swift
//  HostelWorldTest
//
//  Created by Gabriel on 04/12/24.
//

struct PropertiesResponse: Codable {
    let properties: [PropertyDetails]
}

struct PropertyDetails: Codable {
    let id: String
    let name: String
    let city: City
    let latitude: String
    let longitude: String
    let type: String
    let images: [ImageData]
    let overallRating: Rating
}

struct City: Codable {
    let id: String
    let name: String
    let country: String
    let idCountry: String
}

struct ImageData: Codable {
    let prefix: String
    let suffix: String
}

struct Rating: Codable {
    let overall: Int?  
    let numberOfRatings: Int
}

