//
//  PostsService.swift
//  Battlebucks
//
//  Created by Hemendra  on 01/10/25.
//

import Foundation

struct PostsService: PostsServiceProvidable {
    
    private let url = URL(string:APIConstants.posts)!
    
    func fetchPosts() async throws -> [Post] {
        
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Post].self, from: data)
    }
}
