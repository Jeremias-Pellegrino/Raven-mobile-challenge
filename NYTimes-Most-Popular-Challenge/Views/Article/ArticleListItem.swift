//
//  ArticleListItem.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 30/11/2024.
//

import SwiftUI

struct ArticleListItem: View {
    
    @State private var article: Article
    
    private var mediaCaption: String? = nil
    private var url: URL? = nil
    
    init(article: Article) {
        self.article = article
        guard let media = article.media.first else { return }
        self.mediaCaption = media.caption
        if let imageMetadata = media.mediaMetadata.last, let url = URL(string: imageMetadata.url) {
            self.url = url
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink {
                ArticleDetailView(url: URL(string: article.url)!)
            } label: {
                if (UIDevice.current.userInterfaceIdiom == .phone) {
                    VStack {
                        ArticleHeaderView(article: article)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if url != nil {
                            ArticleImage(article: article,
                                         caption: mediaCaption,
                                         url: url)
                        }
                        ArticleFooter(article: article)
                    }
                    .foregroundStyle(Color.black)
                } else {
                    VStack {
                        HStack(alignment: .top) {
                            if url != nil {
                                VStack {
                                    ArticleHeaderView(article: article)
                                    Spacer()
                                    ArticleFooter(article: article)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.35)
                                ArticleImage(article: article,
                                             caption: mediaCaption,
                                             url: url)
                            } else {
                                VStack {
                                    ArticleHeaderView(article: article)
                                    Spacer()
                                    ArticleFooter(article: article)
                                }
                            }
                        }
                    }
                }
            }
            .buttonStyle(.plain)
            .padding(5)
        }
    }
}
