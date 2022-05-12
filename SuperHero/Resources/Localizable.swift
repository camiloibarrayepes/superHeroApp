//
// 11/05/22
// Localizable.swift File
//


import Foundation


final class Localizable {
    static var bundle: Bundle {
        Bundle(for: Localizable.self)
    }
}

extension Localizable {
    static var table: String { "Localizable" }
    
    static var connectionError: String {
        NSLocalizedString(
            "CONNECTION_ERROR",
            tableName: table,
            bundle: bundle,
            comment: "Error message displayed when we can't load the resource")
    }
    
    static var superHeroesTitle: String {
        NSLocalizedString(
            "SUPER_HEROES_TITLE",
            tableName: table,
            bundle: bundle,
            comment: "Title")
    }
    
}
