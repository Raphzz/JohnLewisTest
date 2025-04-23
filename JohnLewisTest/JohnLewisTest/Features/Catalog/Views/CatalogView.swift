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
    
    // MARK: Grid layout

    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]

    // MARK: body

    var body: some View {
        NavigationStack {
            ScrollView {
                switch viewModel.currentState {
                case .loading:
                    loadingView
                case .error:
                    errorState
                case .empty:
                    noResultsAvailableState
                case .loaded:
                    gridView
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
        }
        .onAppear {
            viewModel.loadCatalog()
        }
    }

    // MARK: Private views

    private var loadingView: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 100)
    }

    private var errorState: some View {
        VStack(spacing: 16) {
            Text(L10n.Catalog.apiError)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)

            Button(L10n.Catalog.retry) {
                viewModel.loadCatalog()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 100)
    }

    private var noResultsAvailableState: some View {
        Text(L10n.Catalog.noResults)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 100)
    }

    private var gridView: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(viewModel.items) { item in
                CatalogItemView(item: item)
                    .border(Color(.systemGray6), width: 0.5)
            }
        }
    }
}

#Preview {
    CatalogView()
}
