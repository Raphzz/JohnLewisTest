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

    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.loadCatalog()
        }
    }
}

#Preview {
    CatalogView()
}
