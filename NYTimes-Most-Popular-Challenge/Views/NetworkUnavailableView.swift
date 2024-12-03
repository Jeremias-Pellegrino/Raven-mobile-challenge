//
//  NetworkUnavailableView.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 02/12/2024.
//

import SwiftUI

struct NetworkUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}
