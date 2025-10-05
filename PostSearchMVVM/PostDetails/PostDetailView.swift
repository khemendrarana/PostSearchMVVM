//
//  PostDetailView.swift
//  Battlebucks
//
//  Created by Hemendra  on 01/10/25.
//

import Foundation
import SwiftUI

struct PostDetailView: View {
    
    let post: Post
    @ObservedObject var viewModel: PostsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    Text(post.title.prefix(1).uppercased() + post.title.dropFirst())
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button(action: { viewModel.toggleFavorite(post) }) {
                        Image(systemName: viewModel.isFavorite(post) ? "heart.fill" : "heart")
                            .imageScale(.large)
                    }
                }
                
                Text(post.body)
                    .font(.body)
                
                
                Spacer()
            }
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.bottom))
    }
}



