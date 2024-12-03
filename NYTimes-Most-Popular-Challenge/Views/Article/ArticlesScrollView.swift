//
//  ArticlesScrollView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 03/12/2024.
//

import SwiftUI

struct ArticlesScrollView: View {
    
    var articles: [Article]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 2) {
                ForEach(articles, id: \.id) { article in
                    ArticleListItem(article: article)
                        .padding(8)
                    Divider()
                        .background(Color.black)
                        .padding(1)
                }
            }
        }
    }
}
