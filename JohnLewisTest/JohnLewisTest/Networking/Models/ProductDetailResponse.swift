import Foundation

struct ProductDetailResponse: Codable {
    let detailsData: [ProductDetailData]
    
    struct ProductDetailData: Codable {
        let productId: String
        let details: ProductDetails
        
        struct ProductDetails: Codable {
            let productInformation: String
            let features: [Feature]
            
            struct Feature: Codable {
                let groupName: String
                let attributes: [Attribute]
                
                struct Attribute: Codable {
                    let name: String
                    let value: String
                    let toolTip: String
                }
            }
        }
    }
} 