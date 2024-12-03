//
//  SearchView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 03/12/2024.
//

import SwiftUI

struct SearchView : View {

    @State var isSearching: Bool = true
    @State var searchText = ""

    var articles : [Article] = []
    var results : [Article] {
        get {
            if isSearching {
                let lowercased = searchText.lowercased()
                var results = [Article]()
                
                //no filtering
                if searchText.isEmpty || searchText == "" {
                    results = []
                } else {
                    results = self.articles.filter {
                        $0.title.lowercased().contains(lowercased) || $0.abstract.lowercased().contains(lowercased)
                    }
                }
                return results
            }
            return []
        }
    }
    
    var body: some View {
        ArticlesScrollView(articles: results)
            .searchable(text: $searchText,
                        isPresented: $isSearching, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search articles...")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Look for articles")
                        Image(systemName: "text.magnifyingglass")
                    }
                }
            }
    }
}
