import Foundation

struct CatalogResponse: Codable {
    let showInStockOnly: Bool
    let products: [CatalogItem]
    
    enum CodingKeys: String, CodingKey {
        case showInStockOnly
        case products
    }
}

struct CatalogItem: Identifiable, Codable {
    let productId: String
    let type: String
    let title: String
    let price: Price
    let image: String
    
    var id: String { productId }
    
    struct Price: Codable {
        let was: String
        let then1: String
        let then2: String
        let now: String
        let uom: String
        let currency: String
    }
} 
