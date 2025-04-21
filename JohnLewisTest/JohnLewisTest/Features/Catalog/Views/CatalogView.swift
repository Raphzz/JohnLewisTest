//
//  CatalogView.swift
//  JohnLewisTest
//
//  Created by Raphael Velasqua on 21/04/2025.
//

import SwiftUI

struct CatalogView: View {

    // MARK: ViewModel
    
    @StateObject var viewModel = CatalogViewModel()
    
    // Grid layout
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 100)
                } else if let error = viewModel.error {
                    VStack(spacing: 16) {
                        Text(L10n.Catalog.apiError)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        
                        Button("Retry") {
                            viewModel.loadCatalog()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 100)
                } else if viewModel.items.isEmpty {
                    Text("No results available")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 100)
                } else {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.items) { item in
                            CatalogItemView(item: item)
                                .border(Color(.systemGray6), width: 0.5)
                        }
                    }
                }
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
        }
        .onAppear {
            viewModel.loadCatalog()
        }
    }
}

#Preview {
    CatalogView()
}
