//
// 10/05/22
// NetworkClient.swift File
//

import Alamofire

class NetworkClient {

    let session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func request<T: Decodable>(_ api: URLRequestConvertible, completion: @escaping (_ result: Result<T, AFError>) -> Void) {
        session.request(api).responseDecodable(decoder: JSONDecoder()) { (response: DataResponse<T, AFError>) in
            completion(response.result)
        }
    }
}
