//
//  ProductDetailViewModel.swift
//  JohnLewisTest
//
//  Created by Raphael Velasqua on 23/04/2025.
//

import Foundation

enum ProductDetailState {
    case loading
    case error(String)
    case loaded(ProductDetailResponse.ProductDetailData)
}

@MainActor
class ProductDetailViewModel: ObservableObject {
    // MARK: Published properties
    
    @Published var currentState: ProductDetailState = .loading
    
    // MARK: Private properties
    
    private let repository: ProductDetailRepositoryProtocol
    private let productId: String
    
    // MARK: init
    
    init(productId: String, repository: ProductDetailRepositoryProtocol = ProductDetailRepository()) {
        self.productId = productId
        self.repository = repository
    }
    
    // MARK: Public functions
    
    func loadProductDetails() {
        currentState = .loading
        
        Task {
            do {
                let response = try await repository.fetchProductDetails(productId: productId)
                if let productDetail = response.detailsData.first(where: { $0.productId == productId }) {
                    currentState = .loaded(productDetail)
                } else {
                    currentState = .error("Product not found")
                }
            } catch {
                currentState = .error(error.localizedDescription)
            }
        }
    }
}
