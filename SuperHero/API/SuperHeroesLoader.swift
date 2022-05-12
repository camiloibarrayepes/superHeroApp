//
// 11/05/22
// SuperHeroesLoader.swift File
//


import Alamofire

class SuperHeroesLoader: SuperHeroesLoaderProtocol {
    
    let networkClient: NetworkClient
    let api: URLRequestConvertible
    
    init(networkClient: NetworkClient, api: URLRequestConvertible) {
        self.networkClient = networkClient
        self.api = api
    }
    
    func getSuperHeroes(completion: @escaping (Result<[SuperHero], Error>) -> Void) {
        networkClient.request(api) { [weak self] (response: Result<[SuperHeroesMapper.SuperHeroAPIReponse], AFError>) in
            guard self != nil else { return }
            
            switch response {
            case let .success(apiResponse):
                let superHeroes = apiResponse.map(SuperHeroesMapper.map)
                completion(.success(superHeroes))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
