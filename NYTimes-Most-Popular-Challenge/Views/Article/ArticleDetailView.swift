//
//  ArticleDetailView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 03/12/2024.
//

import SwiftUI
import WebKit

struct ArticleDetailView: View {
    @State var url: URL! = URL(string: "https://www.apple.com")!
    
    var body: some View {
        VStack {
            WebView(url: url).edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
