//
//  NetworkManager.swift
//  NetworkingTest
//
//  Created by IvanL on 9/18/24.
//

import Foundation

enum NetworkError: Error {
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Codable>(from url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return decoded
    }
}
