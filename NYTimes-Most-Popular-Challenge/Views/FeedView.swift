//
//  FeedView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 03/12/2024.
//

import SwiftUI

struct Feed: View {
    
    @ObservedObject var viewModel: ViewModel
    @Binding var isSearching: Bool
    @Binding var presentFilters: Bool
    
    var date: String = "Saturday, December 10, 2024"
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Divider()
                            .background(Color.black.opacity(0.6))
                        Text(date)
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, maxHeight: 28, alignment: .leading)
                            .font(Fonts.newYorkSerif.font(size: .reading).bold())
                            .background(Color.gray.opacity(0.2))
                        Divider()
                            .background(Color.black.opacity(0.6))
                    }
                    if viewModel.isContentAvailable {
                        ArticlesScrollView(articles: viewModel.articles)
                            .navigationDestination(isPresented: $isSearching) {
                                SearchView(articles: viewModel.articles)
                                    .onDisappear {
                                        isSearching = false
                                    }
                            }
                    } else {
                        NetworkUnavailableView()
                    }
                }
            }
            .navigationTitle("Home")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white, for: .automatic)
            .toolbarBackground(.visible, for: .automatic)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("The New York Times")
                        .font(Fonts.newYorkSerif.font(size: .title).bold())
                        .padding(.vertical, 5)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Image(systemName: "text.magnifyingglass")
                            .onTapGesture {
                                isSearching.toggle()
                            }
                        
                        Image(systemName: "slider.horizontal.2.square")
                            .onTapGesture {
                                presentFilters.toggle()
                            }
                        
                    }
                }
            }
        }
    }
}
