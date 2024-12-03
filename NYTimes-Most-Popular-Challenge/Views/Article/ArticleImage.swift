//
//  ArticleImage.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 30/11/2024.
//

import SwiftUI
import UIKit

struct ArticleImage: View {
    
    @Environment(ImagesStore.self) var imagesStore
    
    var article: Article
    var caption: String? = nil
    var url: URL? = nil
    @State var image: AsyncImagePhase?
    
    var body: some View {
        VStack(alignment: .trailing) {
            if let data = imagesStore.get(article.id),
               let uiImage = UIImage(data: data)  {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                AsyncImage(url:url) { image in
                    image.image?
                        .resizable()
                        .scaledToFill()
                        .onAppear() {
                            self.image = image
                            if let data = ImageRenderer(content: image.image)
                                .uiImage?.jpegData(compressionQuality: 1) {
                                imagesStore.add(article.id, data)
                            }
                        }
                }
            }
            if self.image != nil, let caption = caption {
                Text(caption)
                    .font(Fonts.newYorkSerif.font(size: .small))
                    .fontWeight(.thin)
                    .frame(alignment: .topTrailing)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}
