//
// 11/05/22
// SuperHerosView.swift File
//


import Foundation

protocol SuperHerosView: AnyObject {
    func display(_ superHeros: [SuperHeroViewModel])
    func display(_ error: ErrorViewModel)
}
