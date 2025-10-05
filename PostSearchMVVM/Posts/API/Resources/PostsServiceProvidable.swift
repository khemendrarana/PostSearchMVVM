//
//  PostsServiceProvidable.swift
//  Battlebucks
//
//  Created by Hemendra  on 01/10/25.
//

import Foundation


protocol PostsServiceProvidable {
    func fetchPosts() async throws -> [Post]
}
