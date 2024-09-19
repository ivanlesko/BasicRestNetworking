//
//  UserAPI.swift
//  NetworkingTest
//
//  Created by IvanL on 9/18/24.
//

import Foundation

typealias UserListResult = Result<UserListResponse, Error>

struct UserAPI {
    struct Constants {
        fileprivate static let BASE_URL = "https://reqres.in/api"
    }
    
    func fetchUserListRequest(forPage page: Int) -> URLRequest {
        var urlComponents = URLComponents(string: Constants.BASE_URL + "/users")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return request
    }
}
