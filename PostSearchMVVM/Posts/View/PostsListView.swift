//
//  PostsListView.swift
//  Battlebucks
//
//  Created by Hemendra  on 01/10/25.
//

import SwiftUI

struct PostsListView: View {
    @ObservedObject var viewModel: PostsViewModel
    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading posts...")
                    Spacer()
                } else if let err = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(err)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await viewModel.fetchPosts() }
                        }
                    }
                    .padding()
                    Spacer()
                } else {
                    
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.filteredPosts.indices, id: \.self) { index in
                            let post = viewModel.filteredPosts[index]
                            
                            NavigationLink(destination: PostDetailView(post: post, viewModel: viewModel)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(post.title.prefix(1).uppercased() + post.title.dropFirst())
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text("User ID: \(post.userId)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button(action: { viewModel.toggleFavorite(post) }) {
                                        Image(systemName: viewModel.isFavorite(post) ? "heart.fill" : "heart")
                                            .imageScale(.large)
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding()
                                .background(Color(.systemBackground))
                            }
                            
                            // Add separator for all except last row
                            if index != viewModel.filteredPosts.count - 1 {
                                Divider()
                                    .padding(.leading)
                            }
                        }
                    }
                    .padding(.horizontal,8)
                }
                
            }
        }
        .refreshable {
            await viewModel.fetchPosts()
        }
        .searchable(text: $viewModel.searchText, prompt: "Search by title...")
        .navigationTitle("Posts")
        
    }
}

