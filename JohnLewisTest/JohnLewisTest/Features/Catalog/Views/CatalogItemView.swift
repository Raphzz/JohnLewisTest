import SwiftUI

struct CatalogItemView: View {
    let item: CatalogItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            image
            titlePriceContainer
        }
        .frame(height: 300)
        .padding()
        .background(Color(.systemBackground))
        .clipShape(Rectangle())
    }

    private var image: some View {
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
    }

    private var titlePriceContainer: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(item.title)
                .font(.system(size: 14))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            HStack {
                Text("£\(item.price.now)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                Spacer()
            }
        }
    }
}
