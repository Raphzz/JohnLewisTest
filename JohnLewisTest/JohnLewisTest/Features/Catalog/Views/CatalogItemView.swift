import SwiftUI

struct CatalogItemView: View {
    let item: CatalogItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image
            AsyncImage(url: URL(string: "https:\(item.image)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                case .failure:
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                @unknown default:
                    EmptyView()
                }
            }
            .background(Color(.systemBackground))
            
            VStack(alignment: .leading, spacing: 8) {
                // Title
                Text(item.title)
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                // Price
                Text("£\(item.price.now)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 8)
        }
        .background(Color(.systemBackground))
        .clipShape(Rectangle())
    }
} 