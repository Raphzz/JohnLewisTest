import Foundation

protocol ProductDetailRepositoryProtocol {
    func fetchProductDetails(productId: String) async throws -> ProductDetailResponse
}

class ProductDetailRepository: ProductDetailRepositoryProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func fetchProductDetails(productId: String) async throws -> ProductDetailResponse {
        return try await apiClient.fetch("mockData/data2.json?ref_type=head")
    }
} 