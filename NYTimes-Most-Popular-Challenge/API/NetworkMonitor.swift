//
//  ConnectivityMonitor.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 02/12/2024.
//

import Network
import Combine

class NetworkMonitor {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .utility)//.utility?
    public static let shared = NetworkMonitor()
    @Published public var isConnected: Bool = false
    
    private init () {
        monitor.pathUpdateHandler = { path in
            Task {
                await MainActor.run {
                    self.isConnected = path.status == .satisfied
                }
            }
        }
        monitor.start(queue: queue)
    }
}
