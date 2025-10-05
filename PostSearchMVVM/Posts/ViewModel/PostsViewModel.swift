//
//  PostsViewModel.swift
//  Battlebucks
//
//  Created by Hemendra  on 01/10/25.
//

import Foundation

// MARK: - ViewModel
@MainActor
final class PostsViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    
    private let service: PostsServiceProvidable
    private let favoritesKey = "favoritePostIDs"
    @Published private(set) var favoriteIDs: Set<Int> = [] {
        didSet { saveFavorites() }
    }
    
    
    init(service: PostsServiceProvidable = PostsService()) {
        self.service = service
        loadFavorites()
    }
    
    
    var filteredPosts: [Post] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return posts
        }
        let lower = searchText.lowercased()
        return posts.filter { $0.title.lowercased().contains(lower) }
    }
    
    
    var favoritePosts: [Post] {
        posts.filter { favoriteIDs.contains($0.id) }
    }
    
    
    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        do {
            let fetched = try await service.fetchPosts()
            posts = fetched
        } catch {
            errorMessage = "Failed to load posts: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    
    func toggleFavorite(_ post: Post) {
        if favoriteIDs.contains(post.id) {
            favoriteIDs.remove(post.id)
        } else {
            favoriteIDs.insert(post.id)
        }
    }
    
    
    func isFavorite(_ post: Post) -> Bool {
        favoriteIDs.contains(post.id)
    }
    
    
    // MARK: - Persistence
    private func loadFavorites() {
        if let data = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] {
            favoriteIDs = Set(data)
        }
    }
    
    
    private func saveFavorites() {
        let arr = Array(favoriteIDs)
        UserDefaults.standard.set(arr, forKey: favoritesKey)
    }
}


