//
//  UnifiedProfileModel.swift
//  swa_mobile_app
//
//  Created by Arup Sarkar on 1/24/24.
//  Copyright © 2024 swa_mobile_appOrganizationName. All rights reserved.
//

import Foundation
import SalesforceSDKCore


struct ProfileData: Codable {
    var firstName: String
    var lastName: String
    var unifiedId: String
    var phones: [String]
    var emails: [String]
}

struct User: Codable {
    var unifiedId: String
    var phones: [phones]
    var lastName: String
    var firstName: String
    var emails: [emails]

    enum CodingKeys: String, CodingKey {
        case unifiedId = "unifiedId"
        case phones = "phones"
        case lastName = "lastName"
        case firstName = "firstName"
        case emails = "emails"
    }
}

struct phones: Codable {
    var phone: String

    enum CodingKeys: String, CodingKey {
        case phone = "phone"
    }
}

struct emails: Codable {
    var email: String

    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}

class UnifiedProfileViewModel: ObservableObject {
    @Published var profileData: ProfileData?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var result: String?
    @Published var userData: [User]?
    @Published var buttonText = "Refresh Data"
    
    
    func fetchUnifiedProfileData() {
        let accessToken = UserAccountManager.shared.currentUserAccount?.credentials.accessToken
        let instanceURL = UserAccountManager.shared.currentUserAccount?.credentials.instanceUrl
        
        print("Access Token:  \(accessToken!)")
        print("Instance URL : \(instanceURL!.absoluteString)")
        
        let baseURL = "https://swa-dcgenai-demo.my.salesforce.com"
        let path = "/services/apexrest/unifiedprofile/" + "a6bd87793cee4379b2a8d8b31b7e5b11"
        
        let request = RestRequest.customUrlRequest(with: .GET, baseURL: baseURL, path: path, queryParams: nil)
        request.setHeaderValue("Bearer " + accessToken!, forHeaderName: "Authorization")
        request.setHeaderValue("application/json", forHeaderName: "Content-Type")
        

        print("-------- request Start ----------")
        print(request)
        print("-------- request End ----------")
        
        RestClient.shared.send(request: request, { [weak self] (result) in

            switch result {
            case .success( let response ):
                print(result)
                print("-------- response Start ----------")
                print(response.asString())
                self?.result = response.asString()
                do {
                    //let users = try JSONDecoder().decode([User].self, from: response.asData())
                    self?.userData = try JSONDecoder().decode([User].self, from: response.asData())
                    print(self?.userData?[0].firstName as Any)
                    print(self?.userData?[0].lastName as Any)
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.buttonText = "Refresh Data"
                    }
                    
                } catch {
                    print("Error decoding JSON: \(error)")
                    DispatchQueue.main.async {
                        self?.isLoading = false
                        self?.buttonText = "Refresh Data"
                    }
                }
                print("-------- response End ----------")
            case .failure( let error ):
                print(error)
            }
            
        })
        
    }
    
}
