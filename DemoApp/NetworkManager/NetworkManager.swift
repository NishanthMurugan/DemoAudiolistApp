//
//  NetworkManager.swift
//  DemoApp
//
//

import Combine
import Foundation

// Define an API client with a generic method
struct APIClient {
        
    let baseURL = URL(string: "https://pub.microbin.eu/raw/falcon-bison-tiger")!
    
    // Used Generic concept to fetch and decode model
    func getReusableAPIPublsiher<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        
        // Creating a URLSession Data Task Publisher
        return URLSession.shared.dataTaskPublisher(for: baseURL)
            .map(\.data) // Extract only the data from the response
            .decode(type: T.self, decoder: JSONDecoder()) // Decode JSON into the specified type
            .eraseToAnyPublisher() // Type erase to AnyPublisher which prevent the types publicly
    }

}
