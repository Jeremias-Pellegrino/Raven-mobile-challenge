//
//  ViewModel.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 28/11/2024.
//

import SwiftUI
import Combine

@MainActor
class ViewModel: ObservableObject {
    
    struct FilterConfig: Codable {
        var category: ArticleCategory
        var period: DaysPeriod
    }
    
    var apiClient = APIClient()
    var storage = Storage()
    
    var hasSetup: Bool = false
    @Published var isLoading = false
    @Published var articles: [Article] = []
    
    //Filtering
    @Published var isFiltering = false
    @Published var selectedCategory: ArticleCategory = .viewed
    @Published var period: DaysPeriod = .one
    private var latestConfig: FilterConfig = .init(category: .viewed, period: .one)
    private var latestConfigKey = "latestConfig"
    
    //Connectivity state
    @Published var isConnected = false
    @Published var isContentAvailable = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        if let config = try? storage.loadAndDecode(from: latestConfigKey, to: FilterConfig.self) {
            ///Load user's feed prefered config (assuming last one as is)
            latestConfig = config
            self.selectedCategory = config.category
            self.period = config.period
        }
        
        NetworkMonitor.shared.$isConnected.assign(to: &$isConnected)
        
        $isConnected
            .sink { [weak self] isConnected in
                guard let self = self, self.hasSetup else { return }
                if isConnected {
                    self.isContentAvailable = true
                }
            }.store(in: &cancellables)
        
        $isFiltering
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isFiltering in
                guard let self = self, self.hasSetup, !isLoading else { return }
                
                ///While filtering do nothing
                if isFiltering { return }
                
                ///Once finished, compare the selection with the initial state. If they're different, we fetch the items for that configuration, otherwise do nothing.
                if latestConfig.category != self.selectedCategory || latestConfig.period != self.period {
                    latestConfig = .init(category: self.selectedCategory, period: self.period)
                    Task {
                        try self.storage.encodeAndSave(item: self.latestConfig,
                                                       to: self.latestConfigKey)
                    }
                    requestData()
                }
            }
            .store(in: &cancellables)
        
        hasSetup = true
        requestData()
    }
}

extension ViewModel {
    
    func diskFileForCurrentConfigPath() -> String {
        return String(period.rawValue) + selectedCategory.rawValue
    }
    
    ///In order: fetchPrimaryData -> fetchBackupData -> display informative view
    func requestData() {
        isLoading = true
        
        defer {
            isLoading = false
        }

        Task {
            do {
                var requestData: Data?
                let url = try apiClient.builder.endpoint(daysPeriod: period, category: selectedCategory)
                
                if let data = try? await fetchPrimaryData(for: url) {
                    requestData = data
                }
                else if let backupData = try? await fetchBackupData() {
                    requestData = backupData
                }
                
                if let data = requestData {
                    let landing = try JSONDecoder().decode(MostPopular.self, from: data)
                    articles = landing.articles
                    print("succesfully fetched articles: ", articles)
                    try? storage.store(data: data, fileNamed: diskFileForCurrentConfigPath())
                } else {
                    isContentAvailable = false
                }
            }
            catch {
                print(error)
                isContentAvailable = false
            }
        }
        
        func fetchPrimaryData(for url: URL) async throws -> Data {
            return try await apiClient.requestData(with: url)
        }
        
        func fetchBackupData() async throws -> Data? {
            return try storage.read(fileNamed: diskFileForCurrentConfigPath())
        }
    }
}
