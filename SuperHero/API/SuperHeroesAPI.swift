//
// 10/05/22
// HeroAPI.swift File
//

import Alamofire

enum SuperHeroesAPI: URLRequestConvertible {

    case get(baseURL: URL)
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case let .get(baseURL):
            let fullURL = baseURL.appendingPathComponent("/superhero-json-api/raw/4b787c39fcbfd8d069339de94bf8f3a6bda69f3e/superheros.json")
            return URLRequest(url: fullURL)
        }
    }
}
