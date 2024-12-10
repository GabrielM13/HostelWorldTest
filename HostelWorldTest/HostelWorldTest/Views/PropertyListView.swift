//
//  PropertyListView.swift
//  HostelWorldTest
//
//  Created by Gabriel on 04/12/24.
//

import SwiftUI

struct PropertyListView: View {
    @ObservedObject var viewModel = PropertyViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.properties, id: \.id) { property in
                NavigationLink(
                    destination: PropertyDetailView(propertyDetails: property)
                ) {
                    HStack(spacing: 16) {
                        // main image
                        if let prefix = property.images.first?.prefix,
                           let suffix = property.images.first?.suffix,
                           let imageURL = URL(string: prefix + suffix) {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable().scaledToFill()
                                case .failure(_), .empty:
                                    Color.gray.overlay(Text("No Image").foregroundColor(.white))
                                @unknown default:
                                    Color.gray
                                }
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 3)
                        } else {
                            Color.gray.frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 3)
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            // Property name
                            Text(property.name)
                                .font(.headline)
                                .lineLimit(2)
                            
                            // City
                            Text(property.city.name)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            // Rating
                            if let overall = property.overallRating.overall {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                    Text("\(overall)%")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .onAppear {
                viewModel.fetchProperties()
            }
            .navigationTitle("Properties")
        }
    }
}

