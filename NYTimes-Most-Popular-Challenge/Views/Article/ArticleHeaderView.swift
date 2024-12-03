//
//  ArticleTextSectionView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 30/11/2024.
//

import SwiftUI

struct ArticleHeaderView: View {
    
    @Environment(Bookmarks.self) var bookmarks
     
    var article: Article

    var body: some View {
        VStack(spacing: 0) {
            
            HStack(alignment: .top) {
                Text(article.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Fonts.newYorkSerif.font(size: .subtitle).bold())
    
                Image(systemName: bookmarks.contains(article) ? "bookmark.fill" : "bookmark")
                    .onTapGesture {
                        if bookmarks.contains(article) {
                            bookmarks.remove(article)
                        } else {
                            bookmarks.add(article)
                        }
                    }
            }
        
            Spacer().frame(height: 3)
            Text(article.abstract)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Fonts.newYorkSerif.font(size: .reading))
                .fontWeight(.thin)
            
            Spacer()
        }
    }
}
