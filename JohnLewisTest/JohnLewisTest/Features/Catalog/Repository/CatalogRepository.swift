import Foundation

protocol CatalogRepositoryProtocol {
    func fetchCatalog() async throws -> CatalogResponse
}

class CatalogRepository: CatalogRepositoryProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func fetchCatalog() async throws -> CatalogResponse {
        return try await apiClient.fetch("/products/search?q=dishwasher&key=Wu1X6PcTWH")
    }
} 