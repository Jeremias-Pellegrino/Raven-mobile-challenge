//
//  BookmarksView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 03/12/2024.
//

import SwiftUI

struct BookmarksView: View {
    
    @Environment(Bookmarks.self) var bookmarks
    @State var isSearching: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
            if bookmarks.articles.isEmpty {
                VStack {
                    Image(systemName: "bookmark")
                    Text("No bookmarks yet")
                        .font(.headline)
                        .padding()
                }
            } else {
                ArticlesScrollView(articles: bookmarks.articles)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                                Image(systemName: "text.magnifyingglass")
                                    .onTapGesture {
                                        isSearching = true
                                    }
                        }
                    }.navigationDestination(isPresented: $isSearching) {
                        SearchView(articles: bookmarks.articles)
                            .onDisappear {
                                isSearching = false
                            }
            }
        }
    }
}
