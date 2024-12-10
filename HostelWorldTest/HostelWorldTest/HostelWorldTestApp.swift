//
//  HostelWorldTestApp.swift
//  HostelWorldTest
//
//  Created by Gabriel on 04/12/24.
//

import SwiftUI

@main
struct HostelWorldTestApp: App {
    init() {
        APIService.shared.environment = .production
    }
    
    var body: some Scene {
        WindowGroup {
            PropertyListView() // Displaying the list of properties
        }
    }
}
