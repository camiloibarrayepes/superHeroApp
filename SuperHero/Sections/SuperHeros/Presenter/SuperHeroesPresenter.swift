//
// 11/05/22
// SuperHeroesPresenter.swift File
//

import Foundation

protocol SuperHeroesInputPresenter {
    func fetchSuperHeroes()
    func filter(by orderCase: OrderCase)
}

class SuperHeroesPresenter {
    private weak var view: SuperHeroesView?
    private let dataProvider: SuperHeroesLoaderProtocol
    private var superHeroes: [SuperHero] = []
    
    init(view: SuperHeroesView, dataProvider: SuperHeroesLoaderProtocol) {
        self.view = view
        self.dataProvider = dataProvider
    }
    
    func map(superHeroes: [SuperHero]) -> [SuperHeroViewModel] {
        let viewModels = superHeroes.map { superHero in
            SuperHeroViewModel(image: superHero.image,
                               name: superHero.name,
                               publisher: superHero.publisher,
                               height: superHero.appearance.height.last ?? "",
                               weigth: superHero.appearance.weight.last ?? "")
        }
        return viewModels
    }
}

extension SuperHeroesPresenter: SuperHeroesInputPresenter {
    func fetchSuperHeroes() {
        view?.display(LoadingViewModel(loading: true))
        
        dataProvider.getSuperHeroes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(superHeroes):
                self.superHeroes = superHeroes
                let viewModels = self.map(superHeroes: superHeroes)
                self.view?.display(viewModels)
            case .failure:
                self.view?.display(ErrorViewModel(message: Localizable.connectionError))
            }
            
            self.view?.display(LoadingViewModel(loading: false))
        }
    }
    
    func filter(by orderCase: OrderCase) {
        var criteria: (SuperHero, SuperHero) -> Bool
        
        switch orderCase {
        case .higherIntelligence:
            criteria = { $0.powerstats.intelligence > $1.powerstats.intelligence }
        case .lowerIntelligence:
            criteria = { $0.powerstats.intelligence < $1.powerstats.intelligence }
        case .higherStrenght:
            criteria = { $0.powerstats.strength > $1.powerstats.strength }
        case .lowerStrenght:
            criteria = { $0.powerstats.strength < $1.powerstats.strength }
        case .higherSpeed:
            criteria = { $0.powerstats.speed > $1.powerstats.speed }
        case .lowerSpeed:
            criteria = { $0.powerstats.speed < $1.powerstats.speed }
        }
        
        let ordered = superHeroes.sorted(by: criteria)
        let viewModes = map(superHeroes: ordered)
        self.view?.display(viewModes)
    }
}
