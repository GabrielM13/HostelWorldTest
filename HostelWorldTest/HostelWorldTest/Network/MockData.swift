//
//  MockData.swift
//  HostelWorldTest
//
//  Created by Gabriel on 04/12/24.
//

import Foundation

class MockData {
    static let shared = MockData()

    let mockProperties: [PropertyDetails] = [
        PropertyDetails(
            id: "32849",
            name: "STF Vandrarhem Stigbergsliden",
            city: City(
                id: "1530",
                name: "Gothenburg",
                country: "Sweden",
                idCountry: "202"
            ),
            latitude: "57.6992285",
            longitude: "11.9368171",
            type: "HOSTEL",
            images: [
                ImageData(prefix: "http://ucd.hwstatic.com/propertyimages/3/32849/", suffix: "7.jpg"),
                ImageData(prefix: "http://ucd.hwstatic.com/propertyimages/3/32849/", suffix: "1.jpg")
            ],
            overallRating: Rating(overall: 82, numberOfRatings: 400)
        ),
    ]
}

extension MockData {
    var mockPropertyDetails: PropertyDetails {
        return mockProperties.first! // To return the first item
    }
}



