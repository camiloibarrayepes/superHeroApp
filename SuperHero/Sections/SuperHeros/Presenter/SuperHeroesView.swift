//
// 11/05/22
// SuperHeroesView.swift File
//


import Foundation

protocol SuperHeroesView: AnyObject {
    func display(_ superHeroes: [SuperHeroViewModel])
    func display(_ error: ErrorViewModel)
    func display(_ loading: LoadingViewModel)
}
