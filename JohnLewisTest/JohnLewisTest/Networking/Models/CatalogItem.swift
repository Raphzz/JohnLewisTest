import Foundation

struct CatalogItem: Identifiable, Codable {
    let id: String
    let title: String
    let price: Price
    let image: String
    let description: String
    
    struct Price: Codable {
        let now: String
        let currency: String
    }
}

struct CatalogResponse: Codable {
    let products: [CatalogItem]
    let total: Int
} 