//
// 11/05/22
// SuperHerosPresenter.swift File
//

import Foundation

protocol SuperHerosInputPresenter {
    func fetchSuperHeros()
}

class SuperHerosPresenter {
    private weak var view: SuperHerosView?
    private let dataProvider: SuperHerosDataProtocol
    
    init(view: SuperHerosView, dataProvider: SuperHerosDataProtocol) {
        self.view = view
        self.dataProvider = dataProvider
    }
}

extension SuperHerosPresenter: SuperHerosInputPresenter {
    func fetchSuperHeros() {
        dataProvider.getSuperHeros { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(superHeros):
                let viewModels = superHeros.map { superHero in
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
