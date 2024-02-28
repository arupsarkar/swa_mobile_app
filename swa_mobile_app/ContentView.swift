//
//  ContentView.swift
//  swa_mobile_app
//
//  Created by Arup Sarkar on 1/1/24.
//  Copyright © 2024 swa_mobile_appOrganizationName. All rights reserved.
//

import SwiftUI

// Define your tab views
//struct MyTripsView: View {
//    var body: some View {
//        Text("My Trips")
//        // Your custom view content here
//    }
//}

struct FlightStatusView: View {
    var body: some View {
        Text("Flight Status")
        // Your custom view content here
    }
}

struct ConsentManagementView: View {
    var body: some View {
        Text("Consent Management")
        // Your custom view content here
    }
}

struct AccountView: View {
    var body: some View {
        Text("Account")
        // Your custom view content here
    }
}

struct ContentView: View {
    init() {
        // Customize the tab bar appearance
        UITabBar.appearance().backgroundColor = UIColor.systemYellow.withAlphaComponent(0.3) // Light yellow background
    }
    var body: some View {
        CustomTopBar()
        TabView {
            MyTripsView()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("My Trips")
                }
            
            FlightStatusView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Flight Status")
                }
            
            ConsentManagementView()
                .tabItem {
                    Image(systemName: "doc.plaintext")
                    Text("Consent Management")
                }
            
            UnifiedProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
}
