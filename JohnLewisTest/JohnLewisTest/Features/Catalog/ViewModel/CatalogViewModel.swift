//
//  CatalogViewModel.swift
//  JohnLewisTest
//
//  Created by Raphael Velasqua on 21/04/2025.
//

import Foundation

@MainActor
class CatalogViewModel: ObservableObject {

    @Published var items: [CatalogItem] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let repository: CatalogRepositoryProtocol
    
    init(repository: CatalogRepositoryProtocol = CatalogRepository()) {
        self.repository = repository
    }
    
    var title: String {
        String(format: L10n.Catalog.title, "\(items.count)")
    }
    
    func loadCatalog() {
        isLoading = true
        error = nil
        
        Task {
            do {
                let response = try await repository.fetchCatalog()
                items = response.products
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}
