//
//  ArticleFooter.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 03/12/2024.
//

import SwiftUI

struct ArticleFooter: View {
    @State var article: Article

    var body: some View {
        Text(article.publishedDate)
            .font(Fonts.newYorkSerif.font(size: .small))
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
        Text(article.byline)
            .foregroundStyle(Color.black)
            .font(Fonts.newYorkSerif.font(size: .reading))
            .frame(maxWidth: .infinity, alignment: .bottomLeading)
    }
}
