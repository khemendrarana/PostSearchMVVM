//
//  FavoritesView.swift
//  Battlebucks
//
//  Created by Hemendra  on 01/10/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: PostsViewModel
    
    
    var body: some View {
        Group {
            if viewModel.favoritePosts.isEmpty {
                VStack {
                    Text("No favorites yet")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding()
            } else {

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.favoritePosts, id: \.id) { post in
                            NavigationLink(destination: PostDetailView(post: post, viewModel: viewModel)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(post.title.prefix(1).uppercased() + post.title.dropFirst())
                                            .font(.headline)
                                            .lineLimit(2)
                                        Text("User ID: \(post.userId)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Button(action: {
                                        viewModel.toggleFavorite(post)
                                    }) {
                                        Image(systemName: viewModel.isFavorite(post) ? "heart.fill" : "heart")
                                            .imageScale(.large)
                                            .foregroundColor(viewModel.isFavorite(post) ? .red : .gray)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal)
                            }
                            .buttonStyle(.plain)
                            
                            Divider()
                                .padding(.horizontal,10)
                        }
                    }
                }
                .refreshable {
                    await viewModel.fetchPosts()
                }
            }
        }
        .navigationTitle("Favorites")
       
    }
}

