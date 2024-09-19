//
//  ViewModel.swift
//  NetworkingTest
//
//  Created by IvanL on 9/18/24.
//

import Foundation
import Combine

class ViewModel {
    let provider: UserListProvider
    
    @Published public var userList = UserListResponse.default
    
    init(provider: any UserListProvider) {
        self.provider = provider
    }
    
    func fetchUserList(forPage page: Int) {
        Task {
            let result = await self.provider.fetchUserList(forPage:page)
            
            switch result {
            case .success(let response):
                self.userList = response
            case .failure(_):
                break
            }
        }
    }
}
