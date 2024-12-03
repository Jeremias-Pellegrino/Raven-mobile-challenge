//
//  Landing.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 28/11/2024.
//

import SwiftUI
import UIKit

struct Landing: View {
    
    //DataSources
    @StateObject var viewModel: ViewModel = ViewModel()
    @State private var bookmarks = Bookmarks()
    @State private var imagesStore = ImagesStore()
    
    //Control
    @State var presentFilters: Bool = false
    @State var isSearching: Bool = false
    @State var selectedTab: Int = 0
    
    var body: some View {
       
        VStack(spacing: 0) {
            if !viewModel.isConnected {
                Text("No internet connection")
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, maxHeight: 28, alignment: .center)
                    .background(Color.red.opacity(0.2))
                    .border(Color.yellow.opacity(0.2), width: 2)
            }
                TabView(selection: $selectedTab) {
                        Feed(viewModel: viewModel,
                             isSearching: $isSearching,
                             presentFilters: $presentFilters )
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }.tag(0)

                        ProfileView()
                            .tabItem {
                                Label("Me", systemImage: "person")
                            }.tag(1)
                }
                .sheet(isPresented: $presentFilters) {
                    FiltersView(viewModel: viewModel)
                        .presentationDetents([.fraction(UIDevice.current.userInterfaceIdiom == .phone ? 0.3 : 0.5)])
                }
                .environment(bookmarks)
                .environment(imagesStore)
        }.onReceive(viewModel.$articles) { _ in
                imagesStore.save()
        }
    }
}

#Preview {
    Landing()
}
