//
// 10/05/22
// SuperHerosDataProtocol.swift File
//


import Foundation

protocol SuperHerosDataProtocol {
    func getSuperHeros(completion: @escaping (Result<[SuperHero], Error>) -> Void)
}

