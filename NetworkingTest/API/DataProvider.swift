//
//  DataProvider.swift
//  NetworkingTest
//
//  Created by IvanL on 9/18/24.
//

import Foundation

protocol UserListProvider {
    func fetchUserList(forPage page: Int) async -> UserListResult
}

class DataProvider: UserListProvider {
    
    private let userAPI = UserAPI()
    
    func fetchUserList(forPage page: Int) async -> UserListResult {
        let request = userAPI.fetchUserListRequest(forPage: page)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                let response = try JSONDecoder().decode(UserListResponse.self, from: data)
                return .success(response)
                
            } catch {
                return .failure(error)
            }
            
        } catch {
            return .failure(error)
        }
    }
    
}
