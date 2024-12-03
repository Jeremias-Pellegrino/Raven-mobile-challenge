//
//  ProfileView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 02/12/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var isLightMode: Bool = false
    
    var body: some View {
            NavigationStack {
                VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("Jeremias-Linkedin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                    Text("Welcome, Jeremias")
                }
                List {
                    NavigationLink {
                        Text("My info")
                    } label: {
                        Text("Go to ProfileView")
                    }
                    NavigationLink {
                        BookmarksView()
                    } label: {
                        Text("Bookmarks")
                    }
                    Toggle("Dark theme", isOn: $isLightMode)
                }
                .scrollDisabled(true)
                .listStyle(.plain)
            }
        }
    }
}
