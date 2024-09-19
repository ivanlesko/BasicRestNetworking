//
//  UserListResponse.swift
//  NetworkingTest
//
//  Created by IvanL on 9/18/24.
//

import Foundation

struct UserListResponse: Codable {
    struct Support: Codable {
        let url: String
        let text: String
    }
    
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [User]
    let support: Support
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalPages = "total_pages"
        case total
        case data
        case support
    }
    
    // Static default value
    static var `default`: UserListResponse {
        return UserListResponse(
            page: 0,
            perPage: 0,
            total: 0,
            totalPages: 0,
            data: [],  // Empty user list
            support: Support(url: "", text: "")  // Default support values
        )
    }
}
