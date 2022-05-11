//
// 10/05/22
// HeroAPI.swift File
//

import Alamofire

enum SuperHerosAPI: URLRequestConvertible {

    static let baseURL = URL(string: "https://bitbucket.org/consultr")!
    
    case get
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .get:
            let fullURL = SuperHerosAPI.baseURL.appendingPathComponent("/superhero-json-api/raw/4b787c39fcbfd8d069339de94bf8f3a6bda69f3e/superheros.json")
            return URLRequest(url: fullURL)
        }
    }
}

class SuperHerosMapper {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getSuperHeros(completion: @escaping (Result<[SuperHero], Error>) -> Void) {
        networkClient.request(SuperHerosAPI.get) { [weak self] (response: Result<[SuperHeroAPIReponse], AFError>) in
            guard let self = self else { return }
            
            switch response {
            case let .success(apiResponse):
                completion(.success(apiResponse.map(self.map)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func map(apiReponse: SuperHeroAPIReponse) -> SuperHero {
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
                                         race: apiReponse.appearance.race,
                                         height: apiReponse.appearance.height,
                                         weight: apiReponse.appearance.weight),
                  image: apiReponse.images.md,
                  publisher: apiReponse.biography.publisher)
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
            let race: String
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
            let publisher: String
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
