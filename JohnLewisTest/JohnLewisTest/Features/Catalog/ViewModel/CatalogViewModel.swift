//
//  CatalogViewModel.swift
//  JohnLewisTest
//
//  Created by Raphael Velasqua on 21/04/2025.
//

import Foundation

enum CatalogState {
    case loading
    case error(String)
    case empty
    case loaded
}

@MainActor
class CatalogViewModel: ObservableObject {

    // MARK: Published properties

    @Published var currentState: CatalogState = .loading
    @Published var items: [CatalogItem] = []
    @Published var error: Error?

    // MARK: Private properties

    private let repository: CatalogRepositoryProtocol

    // MARK: Public properties

    var title: String {
        guard !items.isEmpty else {
            return String(format: L10n.Catalog.title)
        }

        return String(format: L10n.Catalog.titleLoaded, "\(items.count)")
    }

    // MARK: init

    init(repository: CatalogRepositoryProtocol = CatalogRepository()) {
        self.repository = repository
    }

    // MARK: Public functions

    func loadCatalog() {
        currentState = .loading
        error = nil
        
        Task {
            do {
                let response = try await repository.fetchCatalog()
                items = response.products
                currentState = items.isEmpty ? .empty : .loaded
            } catch {
                self.error = error
                currentState = .error(error.localizedDescription)
            }
        }
    }
}
