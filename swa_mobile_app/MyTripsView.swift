//
//  MyTripsView.swift
//  swa_mobile_app
//
//  Created by Arup Sarkar on 1/1/24.
//  Copyright © 2024 swa_mobile_appOrganizationName. All rights reserved.
//

import SwiftUI

// Define your data model
struct BoardingPass {
    var departure: String
    var arrival: String
    var flightNumber: String
    var gate: String
    var group: String
    var position: String
    // Add other properties as per your screenshot
}

// Define a sample boarding pass with fake data
let sampleBoardingPass = BoardingPass(departure: "8:14 AM", arrival: "12:15 PM", flightNumber: "MWVGL4", gate: "12", group: "A", position: "36")



// Create a view for the boarding pass
struct BoardingPassView: View {
    var boardingPass: BoardingPass
    @ObservedObject var flightDetailsModel = FlighDetailsModel()
    
    
    func cancelTrip() {
        print("Cancel Trip - start")
        let payload = MyPayload(key: "hello key", msg: "hello msg")
        flightDetailsModel.startProducer(with: payload)
        print("Cancel Trip - end")
    }

    var body: some View {
        
        ZStack {
            Image("background.png") // Replace "backgroundImageName" with the name of your image asset
                .resizable() // Make the image resizable
                .aspectRatio(contentMode: .fill) // Fill the aspect ratio of the image to the container
                .edgesIgnoringSafeArea(.all)
            ZStack {
                // Card Background
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    // Top row with destination, date, and confirmation code
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Chicago, ORD")
                                .font(.headline)
                            Text("Wednesday, September 30")
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("CONFIRMATION\nMWVGL4")
                            .font(.caption)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    // Divider
                    Divider()
                    
                    // Flight times
                    HStack {
                        VStack(alignment: .leading) {
                            Text("DEPARTS")
                                .font(.caption)
                            Text("8:14 AM")
                                .font(.title)
                            Text("Chicago - ORD")
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "airplane.departure")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("ARRIVES")
                                .font(.caption)
                            Text("12:15 PM")
                                .font(.title)
                            Text("Miami, MIA")
                                .font(.caption)
                        }
                    }
                    
                    // Divider
                    Divider()
                    
                    // Gate, group, and position
                    HStack {
                        InfoBox(label: "GATE", value: "12")
                        InfoBox(label: "GROUP", value: "A")
                        InfoBox(label: "POSITION", value: "36")
                    }
                    
                    // Boarding pass button
                    Button(action: {
                        // Handle boarding pass details action
                    }) {
                        Text("Boarding pass")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                    
                    // Details button
                    Button(action: {
                        // Handle details action
                    }) {
                        Text("Details")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    
                    // Details button
                    Button(action: {
                        // Handle details action
                        cancelTrip()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                    
                }
                .padding()
            }
            .frame(width: 300, height: 220)
            .padding()
        }
        }

}

struct InfoBox: View {
    var label: String
    var value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            Text(label)
                .font(.caption)
                .foregroundColor(.black)
        }
    }
}

struct MyTripsView: View {
    var body: some View {
        ZStack {
            // Add your background image
            Image("backgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            // Overlay your text
            //Text("Your fall getaway comes with no hidden fees.")
                // Style the text
            
            VStack {
                // Top bar with welcome message, points, etc.
                // Use HStack for horizontal elements

                // Middle section with boarding pass details
                BoardingPassView(boardingPass: sampleBoardingPass)

                // Bottom bar with buttons for actions
                // Use HStack for horizontal elements
            }
        }
    }
}

#Preview {
    MyTripsView()
}
