//
//  FlightDetails.swift
//  swa_mobile_app
//
//  Created by Arup Sarkar on 1/1/24.
//  Copyright © 2024 swa_mobile_appOrganizationName. All rights reserved.
//

import Foundation
import SwiftUI
import SalesforceSDKCore

// Define your payload structure
struct MyPayload: Codable {
    var key: String
    var msg: String
}

struct FlightDetailsData: Codable {
    var flightId: String
    var deviceId: String
    var lastModifiedDate: String
    var eventDateTime: String
    var dataSourceObject: String
    var dataSource: String
    var category: String
    var eventId: String
    var eventType: String
    var sessionId: String
    var internalOrg: String
    var flightNumber: String
    var userId: String
    var statusCode: String
    var origin: String
    var destination: String
    var flight_date: String
    var flight_time: String

    enum CodingKeys: String, CodingKey {
        case flightId = "flight_id"
        case deviceId = "deviceId"
        case lastModifiedDate = "Last_Modified_Date"
        case eventDateTime = "eventDateTime"
        case dataSourceObject = "Data_Source_Object"
        case dataSource = "Data_Source"
        case category = "category"
        case eventId = "eventId"
        case eventType = "eventType"
        case sessionId = "sessionId"
        case internalOrg = "Internal_Org"
        case flightNumber = "flight_number"
        case userId = "userId"
        case statusCode = "status_code"
        case origin = "origin"
        case destination = "destination"
        case flight_date = "flight_date"
        case flight_time = "flight_time"
    }
}

struct FlightDetailsDataContainer: Codable {
    let data: [FlightDetailsData]
}

class FlighDetailsModel: ObservableObject {
    // Observable properties that your views can react to
//    let payload = MyPayload(key: "value1", msg: "hello world")
    
    
    func startProducer(with payload: MyPayload) {
        
        
        let currentDate = Date()
        print(currentDate.toDateFormat())
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
            flight_date: currentDate.toDateFormat(),
            flight_time: "9:20AM"
        )

        
        do {
            let eventDataContainer = FlightDetailsDataContainer(data: [event])
            let jsonData2 = try JSONEncoder().encode(eventDataContainer)
            let jsonString = String(data: jsonData2, encoding: .utf8) ?? ""
            let payload = MyPayload(key: "value1", msg: jsonString)
            
            
            //
            let jsonData = try JSONEncoder().encode(payload)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                let jsonFormattedString = jsonString.replacingOccurrences(of: "\\\\", with: "")
                print(jsonFormattedString)
                // Use this jsonString as the payload in your URL query parameter
                if let encodedJsonString = jsonFormattedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    
                    // Construct the complete URL with the encoded JSON string as a query parameter
                    let urlString = "https://sfdc-ctx.herokuapp.com/api/kafka/startProducer?payload=\(encodedJsonString)"
                    
                    if let url = URL(string: urlString) {
                        // Create a URLRequest object
                        var request = URLRequest(url: url)
                        request.httpMethod = "GET" // Specify the HTTP method. Adjust if necessary

                        // Start the network request
                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                            // Handle the response
                            if let error = error {
                                // Handle the error
                                print("Network request error: \(error)")
                                return
                            }

                            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                                // Check for HTTP errors
                                print("HTTP Error: \(httpResponse.statusCode)")
                                return
                            }

                            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                                // Process the response data
                                print("Response data: \(responseString)")
                            }
                        }
                        
                        // Start the task
                        task.resume()
                    } else {
                        print("Error: Invalid URL")
                    }
                } else {
                    print("Error: Unable to encode JSON string as URL parameter")
                }
            } else {
                print("Failed to convert JSON data to String.")
            }
        } catch {
            print("Failed to encode MyPayload to JSON: \(error)")
        }
        // Convert your payload to JSON data
        guard let jsonData = try? JSONEncoder().encode(payload) else {
            print("Error: Unable to encode payload to JSON")
            return
        }
        

    }
}


extension Date {
    func toISO8601Format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        formatter.locale = Locale(identifier: "en_US_POSIX") // POSIX locale to ensure consistent formatting
        return formatter.string(from: self)
    }
}


extension Date {
    func toDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        formatter.locale = Locale(identifier: "en_US_POSIX") // POSIX locale to ensure consistent formatting
        return formatter.string(from: self)
    }
}
