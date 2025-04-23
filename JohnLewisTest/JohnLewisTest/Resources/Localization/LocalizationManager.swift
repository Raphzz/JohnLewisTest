import Foundation

enum L10n {
    enum Common {
        static let appName = NSLocalizedString("app_name", comment: "App name")
    }
    
    enum Catalog {
        static let title = NSLocalizedString("catalog_title", comment: "Catalog screen title")
        static let titleLoaded = NSLocalizedString("catalog_title_loaded", comment: "Catalog screen title with items count")
        static let apiError = NSLocalizedString("catalog_error", comment: "Error fetching API")
        static let retry = NSLocalizedString("catalog_retry", comment: "Retry button text")
        static let noResults = NSLocalizedString("catalog_no_results", comment: "No results available message")
    }
} 
