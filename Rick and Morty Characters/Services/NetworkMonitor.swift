//
//  NetworkMonitor.swift
//  Rick and Morty Characters
//
//  Created by Ravil Gubaidulin on 19.07.2024.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    var isConnected = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            ///updated if connected or not
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: queue)
    }
}
