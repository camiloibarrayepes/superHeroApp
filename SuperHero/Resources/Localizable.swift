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
    
    static var orderBy: String {
        NSLocalizedString(
            "ORDER_BY",
            tableName: table,
            bundle: bundle,
            comment: "Order by")
    }
    
    static var higherIntelligence: String {
        NSLocalizedString(
            "HIGHER_INTELLIGENCE",
            tableName: table,
            bundle: bundle,
            comment: "Higher Intelligence")
    }
    
    static var lowerIntelligence: String {
        NSLocalizedString(
            "LOWER_INTELLIGENCE",
            tableName: table,
            bundle: bundle,
            comment: "Lower Intelligence")
    }
    
    static var higherStrenght: String {
        NSLocalizedString(
            "HIGHER_STRENGHT",
            tableName: table,
            bundle: bundle,
            comment: "Higher Strenght")
    }
    
    static var lowerStrenght: String {
        NSLocalizedString(
            "LOWER_STRENGHT",
            tableName: table,
            bundle: bundle,
            comment: "Lower Strenght")
    }
    
    static var higherSpeed: String {
        NSLocalizedString(
            "HIGHER_SPEED",
            tableName: table,
            bundle: bundle,
            comment: "Higher Speed")
    }
    
    static var lowerSpeed: String {
        NSLocalizedString(
            "LOWER_SPEED",
            tableName: table,
            bundle: bundle,
            comment: "Lower Speed")
    }
    
    static var cancel: String {
        NSLocalizedString(
            "CANCEL",
            tableName: table,
            bundle: bundle,
            comment: "Cancel")
    }
    
    
}
