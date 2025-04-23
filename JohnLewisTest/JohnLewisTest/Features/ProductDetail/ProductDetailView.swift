//
//  ProductDetailView.swift
//  JohnLewisTest
//
//  Created by Raphael Velasqua on 23/04/2025.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Navigation bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.primary)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                // Product image
                AsyncImage(url: URL(string: "https://media.johnlewiscontent.com/i/JohnLewis/237172361?")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    case .failure:
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                            .frame(height: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Price section
                    Group {
                        Text("£\(viewModel.price)")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if !viewModel.guarantee.isEmpty {
                            Text(viewModel.guarantee)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Product Information
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Product information")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(viewModel.productInformation)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                    // Product Specification
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Product specification")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        ForEach(viewModel.specifications, id: \.name) { spec in
                            HStack {
                                Text(spec.name)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(spec.value)
                                    .foregroundColor(.primary)
                            }
                            .padding(.horizontal)
                            Divider()
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.loadProductDetails()
        }
    }
}

extension ProductDetailViewModel {
    var price: String {
        switch currentState {
        case .loaded(let data):
            return "489.00" // Replace with actual price from your data
        default:
            return ""
        }
    }
    
    var guarantee: String {
        switch currentState {
        case .loaded(let data):
            return "2 year guarantee included"
        default:
            return ""
        }
    }
    
    var productInformation: String {
        switch currentState {
        case .loaded(let data):
            return data.details.productInformation
        default:
            return ""
        }
    }
    
    struct Specification: Identifiable {
        let id = UUID()
        let name: String
        let value: String
    }
    
    var specifications: [Specification] {
        switch currentState {
        case .loaded(let data):
            return data.details.features.flatMap { feature in
                feature.attributes.map { attribute in
                    Specification(name: attribute.name, value: attribute.value)
                }
            }
        default:
            return []
        }
    }
}

#Preview {
    ProductDetailView(viewModel: ProductDetailViewModel())
}
