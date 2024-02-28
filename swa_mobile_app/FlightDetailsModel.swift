//
//  FlightDetailsModel.swift
//  swa_mobile_app
//
//  Created by Arup Sarkar on 1/4/24.
//  Copyright © 2024 swa_mobile_appOrganizationName. All rights reserved.
//

import Foundation
import SwiftUI
import SalesforceSDKCore

//struct FlightDetailsData: Codable {
//    var flightId: String
//    var deviceId: String
//    var lastModifiedDate: String
//    var eventDateTime: String
//    var dataSourceObject: String
//    var dataSource: String
//    var category: String
//    var eventId: String
//    var eventType: String
//    var sessionId: String
//    var internalOrg: String
//    var flightNumber: String
//    var userId: String
//    var statusCode: String
//    var origin: String
//    var destination: String
//    var flightDate: Date
//    var flightTime: String
//
//    enum CodingKeys: String, CodingKey {
//        case flightId = "flightId"
//        case deviceId = "deviceId"
//        case lastModifiedDate = "Last_Modified_Date"
//        case eventDateTime = "eventDateTime"
//        case dataSourceObject = "Data_Source_Object"
//        case dataSource = "Data_Source"
//        case category = "category"
//        case eventId = "eventId"
//        case eventType = "eventType"
//        case sessionId = "sessionId"
//        case internalOrg = "Internal_Org"
//        case flightNumber = "flightNumber"
//        case userId = "userId"
//        case statusCode = "status_code"
//        case origin = "origin"
//        case destination = "destination"
//        case flightDate = "2024-01-04"
//        case flightTime = "9:50AM"
//    }
//}
//
//struct FlightDetailsDataContainer: Codable {
//    let data: [FlightDetailsData]
//}




class FlightDetailsModel: ObservableObject {
    
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isRequestInProgress = false
    @Published var buttonText = "Cancel"
    
    

    

    func newRound() {
        
        DispatchQueue.main.async {
            self.isRequestInProgress = true
            self.buttonText = "Request in progress.."
        }
        
        // call the data cloud ingestion API to post the data
        let currentDate = Date()
        let formattedDate = currentDate.toISO8601Format()
        let uniqueId = UUID().uuidString
        let event = FlightDetailsData(
            flightId: uniqueId,
            deviceId: "B47FD0FF-C022-429F-A59F-7414DF3E3C99",
            lastModifiedDate: formattedDate,
            eventDateTime: formattedDate,
            dataSourceObject: "flight_details_event_api-1dsHs000000TWJ6IAO",
            dataSource: "1dsHs000000TWJ6IAO",
            category: "Flight Details",
            eventId: uniqueId,
            eventType: "Flight Details Change Request",
            sessionId: UUID().uuidString,
            internalOrg: UserAccountManager.shared.currentUserAccountIdentity!.orgId,
            flightNumber: "W1234",
            userId: "2c1b2a8da0a7c6232f758c8a79eb3060",
            statusCode: "Active",
            origin: "Chicago",
            destination: "Miami",
            flight_date: "2024-01-04",
            flight_time: "9:20AM"
        )
        
        let eventDataContainer = FlightDetailsDataContainer(data: [event])
        do {
            let jsonData = try JSONEncoder().encode(eventDataContainer)
            print(jsonData)
            
            isLoading = true
            errorMessage = nil
            let accessToken = UserAccountManager.shared.currentUserAccount?.credentials.accessToken
            let instanceURL = UserAccountManager.shared.currentUserAccount?.credentials.instanceUrl
            
            print("Access Token:  \(accessToken!)")
            print("Instance URL : \(instanceURL!.absoluteString)")
            
            let baseURL = instanceURL!.absoluteString
            let path = "/services/apexrest/flightdetailsevent/"
            
//            let request = RestRequest.customUrlRequest(with: .POST, baseURL: baseURL, path: path, queryParams: nil)
            let request = RestRequest.customUrlRequest(with: .POST, baseURL: baseURL, path: path, queryParams: nil)
            request.setHeaderValue("Bearer " + accessToken!, forHeaderName: "Authorization")
            request.setHeaderValue("application/json", forHeaderName: "Content-Type")
            request.setCustomRequestBodyData(jsonData, contentType: "application/json")
            
            RestClient.shared.send(request: request, { [weak self] (result) in
                switch result {
                    case .success(let response):
                        print(result)
                        print("-------- response Start ----------")
                        DispatchQueue.main.async {
                            self?.isRequestInProgress = false
                            self?.buttonText = "Cancel"
                        }
                        print(response.asString())
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self?.isRequestInProgress = false
                            self?.buttonText = "Cancel"
                        }
                    
                        print(error)
                }
                
                
            })
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }


        
        
        
    }
    
}

//extension Date {
//    func toISO8601Format() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
//        formatter.locale = Locale(identifier: "en_US_POSIX") // POSIX locale to ensure consistent formatting
//        return formatter.string(from: self)
//    }
//}
//
//
//extension Date {
//    func toDateFormat() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
//        formatter.locale = Locale(identifier: "en_US_POSIX") // POSIX locale to ensure consistent formatting
//        return formatter.string(from: self)
//    }
//}
//
