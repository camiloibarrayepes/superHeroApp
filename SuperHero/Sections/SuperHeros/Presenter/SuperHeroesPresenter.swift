//
// 11/05/22
// SuperHeroesPresenter.swift File
//

import Foundation

protocol SuperHeroesInputPresenter {
    func fetchSuperHeroes()
}

class SuperHeroesPresenter {
    private weak var view: SuperHeroesView?
    private let dataProvider: SuperHeroesLoaderProtocol
    
    init(view: SuperHeroesView, dataProvider: SuperHeroesLoaderProtocol) {
        self.view = view
        self.dataProvider = dataProvider
    }
}

extension SuperHeroesPresenter: SuperHeroesInputPresenter {
    func fetchSuperHeroes() {
        dataProvider.getSuperHeroes { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(superHeroes):
                let viewModels = superHeroes.map { superHero in
                    SuperHeroViewModel(image: Data(),
                                       name: superHero.name,
                                       publisher: superHero.publisher,
                                       height: superHero.appearance.height.last ?? "",
                                       weigth: superHero.appearance.weight.last ?? "")
                }
                self.view?.display(viewModels)
            case .failure:
                self.view?.display(ErrorViewModel(message: Localizable.connectionError))
            }
        }
    }
}
