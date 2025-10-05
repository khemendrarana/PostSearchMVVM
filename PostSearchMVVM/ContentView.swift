//
//  ContentView.swift
//  Battlebucks
//
//  Created by Hemendra  on 01/10/25.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var vm = PostsViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                PostsListView(viewModel: vm)
            }
            .tabItem {
                Label("Posts", systemImage: "list.bullet")
            }
            
            
            NavigationView {
                FavoritesView(viewModel: vm)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
        .task {
            // initial fetch
            await vm.fetchPosts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



