//
//  PropertyDetailView.swift
//  HostelWorldTest
//
//  Created by Gabriel on 04/12/24.
//

import SwiftUI
import MapKit

struct PropertyDetailView: View {
    var propertyDetails: PropertyDetails

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Imagem principal
                if let firstImage = propertyDetails.images.first {
                    AsyncImage(url: URL(string: firstImage.prefix + firstImage.suffix)) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable().scaledToFill()
                        case .failure(_), .empty:
                            Color.gray.overlay(Text("Image not available").foregroundColor(.white))
                        @unknown default:
                            Color.gray
                        }
                    }
                    .frame(height: 250)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    // Name and type
                    Text(propertyDetails.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Type: \(propertyDetails.type)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Rating
                    if let overall = propertyDetails.overallRating.overall {
                        HStack {
                            Text("Rating:")
                                .font(.headline)
                            Text("\(overall)%")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Divider()
                    
                    // Setup description
                    Text("Description")
                        .font(.headline)
                    Text(propertyDetails.name) // Ajuste para descrição real
                        .font(.body)
                        .multilineTextAlignment(.leading)
                    
                    Divider()
                    
                    // Location
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Location")
                            .font(.headline)
                        Text("City: \(propertyDetails.city.name), \(propertyDetails.city.country)")
                        Text("Coordinates: \(propertyDetails.latitude), \(propertyDetails.longitude)")
                        
                        Button(action: {
                            openInMaps(latitude: propertyDetails.latitude, longitude: propertyDetails.longitude)
                        }) {
                            HStack {
                                Image(systemName: "map")
                                Text("Open in Maps")
                            }
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                        }
                    }
                    
                    Divider()
                    
                    // Setup Gallery
                    if propertyDetails.images.count > 1 {
                        Text("Gallery")
                            .font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(propertyDetails.images, id: \.prefix) { image in
                                    AsyncImage(url: URL(string: image.prefix + image.suffix)) { phase in
                                        switch phase {
                                        case .success(let img):
                                            img.resizable().scaledToFill()
                                        case .failure(_), .empty:
                                            Color.gray
                                        @unknown default:
                                            Color.gray
                                        }
                                    }
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(8)
                                    .shadow(radius: 3)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func openInMaps(latitude: String, longitude: String) {
        guard let lat = Double(latitude), let long = Double(longitude) else { return }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = propertyDetails.name
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}






