//
// 10/05/22
// SuperHeroesDataProtocol.swift File
//


import Foundation

protocol SuperHeroesLoaderProtocol {
    func getSuperHeroes(completion: @escaping (Result<[SuperHero], Error>) -> Void)
}
