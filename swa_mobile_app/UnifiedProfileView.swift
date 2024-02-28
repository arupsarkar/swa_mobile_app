//
//  UnifiedProfileView.swift
//  swa_mobile_app
//
//  Created by Arup Sarkar on 1/19/24.
//  Copyright © 2024 swa_mobile_appOrganizationName. All rights reserved.
//

import SwiftUI

struct UnifiedProfileView: View {
    // Mock data to simulate the information displayed in the screenshot
    @ObservedObject var viewModel = UnifiedProfileViewModel()
    var name: String = "Lauren Bailey"
    var phoneNumbers: [String] = ["4155551212"]
    var emails: [String] = ["lbailey@example.com"]
    
    var body: some View {
        VStack {
            

            
            VStack(alignment: .leading) {
                
                VStack(alignment: .center, spacing: 5) {
//                    Text(name)
//                        .font(.title)
//                        .bold()
                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let userData = viewModel.userData {
                        
                        VStack(alignment: .center, spacing: 10) {
                            AsyncImage(url: URL(string: "https://picsum.photos/200/300")) { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fill)
                                     .frame(width: 100, height: 100)
                                     .clipShape(Circle())
                            } placeholder: {
                                ProgressView() // Displays a loading indicator while the image is loading
                            }
                        }


                        Text("Name: \(userData[0].firstName) \(userData[0].lastName)")
                        
                        List(userData, id: \.unifiedId) { user in
                            Text("\(user.firstName) \(user.lastName)")
                                                        .font(.headline)
                                                        .padding(.top)
                            
                            GroupBox(
                                label: Text("Phones")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            ) {
                                ForEach(user.phones, id: \.phone) { phone in
                                    HStack {
                                        Label(phone.phone.dropFirst().dropLast(), systemImage: "phone")
                                    }
                                    .padding(.vertical, 2)
                                    

                                }
                            }
                            
                            GroupBox(
                                label: Text("Emails")
                                    .frame(maxWidth: .infinity, alignment: .center)
                            ) {
                                ForEach(user.emails, id: \.email) { email in
                                    
                                    HStack {
                                        Label(email.email.dropFirst().dropLast(), systemImage: "envelope")
                                            .padding(.leading)
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                            
                        }

                    }
                    
                }
                .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    // Action for Refresh Data
                    viewModel.fetchUnifiedProfileData()
                }) {
                    Text("Refresh Data")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
                

        }
//        .background(Color.black)
//        .foregroundColor(.white)
    }
}

// Only needed for Canvas Preview in Xcode
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UnifiedProfileView()
            .preferredColorScheme(.dark)
    }
}
