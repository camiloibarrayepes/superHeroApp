//
// 11/05/22
// SuperHeroesMapper.swift File
//


import Foundation

class SuperHeroesMapper {

    static func map(apiReponse: SuperHeroAPIReponse) -> SuperHero {
        SuperHero(id: apiReponse.id,
                  name: apiReponse.name,
                  slug: apiReponse.slug,
                  powerstats: Powerstats(intelligence: apiReponse.powerstats.intelligence,
                                         strength: apiReponse.powerstats.strength,
                                         speed: apiReponse.powerstats.speed,
                                         durability: apiReponse.powerstats.durability,
                                         power: apiReponse.powerstats.power,
                                         combat: apiReponse.powerstats.combat),
                  appearance: Appearance(gender: apiReponse.appearance.gender,
                                         race: apiReponse.appearance.race ?? "",
                                         height: apiReponse.appearance.height,
                                         weight: apiReponse.appearance.weight),
                  image: apiReponse.images.md,
                  publisher: apiReponse.biography.publisher ?? "")
    }
    
    // MARK: - SuperHeroAPIReponse
    struct SuperHeroAPIReponse: Codable {
        let id: Int
        let name: String
        let slug: String
        let powerstats: Powerstats
        let appearance: Appearance
        let biography: Biography
        let work: Work
        let connections: Connections
        let images: Images
        
        // MARK: - Appearance
        struct Appearance: Codable {
            let gender: String
            let race: String?
            let height: [String]
            let weight: [String]
            let eyeColor: String
            let hairColor: String
        }

        // MARK: - Biography
        struct Biography: Codable {
            let fullName: String
            let alterEgos: String
            let aliases: [String]
            let placeOfBirth: String
            let firstAppearance: String
            let publisher: String?
            let alignment: String
        }

        // MARK: - Connections
        struct Connections: Codable {
            let groupAffiliation: String
            let relatives: String
        }

        // MARK: - Images
        struct Images: Codable {
            let xs: String
            let sm: String
            let md: String
            let lg: String
        }

        // MARK: - Powerstats
        struct Powerstats: Codable {
            let intelligence: Int
            let strength: Int
            let speed: Int
            let durability: Int
            let power: Int
            let combat: Int
        }

        // MARK: - Work
        struct Work: Codable {
            let occupation: String
            let base: String
        }
    }
}
