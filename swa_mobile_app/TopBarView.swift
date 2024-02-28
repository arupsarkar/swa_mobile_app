//
//  TopBarView.swift
//  swa_mobile_app
//
//  Created by Arup Sarkar on 1/1/24.
//  Copyright © 2024 swa_mobile_appOrganizationName. All rights reserved.
//

import SwiftUI

struct CustomTopBar: View {
    var body: some View {
        HStack {
            // Profile name on the left
            Text("Lauren")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.top, 30)

            Spacer() // Pushes the content to the sides
            
            // Profile icon on the right
            Image(systemName: "person.crop.circle.fill")
                .foregroundColor(.white)
                .font(.title)
                .padding(.top, 30)
        }
        .padding() // Add some padding inside the HStack
        .background(Color.blue) // Set the background color of the HStack
        .edgesIgnoringSafeArea(.top) // Extend the background to the top edges of the screen
    }
}

struct TopBarView: View {
    var body: some View {
        VStack {
            CustomTopBar() // Include the custom top bar

            // The rest of your content view goes here
            Spacer() // Use Spacer to push all content to the top
        }
    }
}

#Preview {
    TopBarView()
}
