//
//  FiltersView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 01/12/2024.
//

import SwiftUI

struct FiltersView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Adjust your preferences")
                    .padding()
                Spacer()
            }
            
            VStack(spacing: 0) {
                HStack {
                    Text("Category")
                        .padding()
                    Spacer()
                }
                Picker("Select an option", selection: $viewModel.selectedCategory) {
                    ForEach(ArticleCategory.allCases, id: \.self) { option in
                        Text(option.rawValue)
                            .padding()
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
           
            VStack(spacing: 0) {
                HStack {
                    Text("Period of time (days)")
                        .padding()
                    Spacer()
                }
                
                Picker("Select an option", selection: $viewModel.period) {
                    ForEach(DaysPeriod.allCases, id: \.self) { option in
                        Text(option.rawValue.description)
                            .padding()
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        }
        
        .onAppear{
            viewModel.isFiltering.toggle()
        }
        .onDisappear {
            viewModel.isFiltering.toggle()
        }
    }
}
