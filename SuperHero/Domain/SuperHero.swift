//
// 10/05/22
// SuperHero.swift File
//


import Foundation

struct SuperHero {
    let id: Int
    let name: String
    let slug: String
    let powerstats: Powerstats
    let appearance: Appearance
    let image: String
}

struct Powerstats {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Appearance {
    let gender: String
    let race: String
    let height: [String]
    let weight: [String]
}

