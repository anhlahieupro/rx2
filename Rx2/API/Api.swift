import UIKit
import RxSwift
import RxCocoa
import Alamofire

struct Api {
    static func request<Response: BaseResponse>(url: String,
                                                method: HTTPMethod = .get,
                                                parameters: Parameters? = nil,
                                                headers: HTTPHeaders = ["Content-Type": "application/json"],
                                                ResponseType: Response.Type) -> Single<Response> {
        
        return Single.create { single in
            
            AF.request(url,
                       method: method,
                       parameters: parameters,
                       encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
                       headers: headers)
            .responseDecodable(of: Response.self) { response in
                switch response.result {
                    
                case let .success(data):
                    let code = response.response?.statusCode ?? 400
                    data.code = code
                    
                    switch code {
                    case 200...299:
                        single(.success(data))
                        
                    default:
                        single(.failure(BaseError(code: code, response: data)))
                    }
                    
                case let .failure(error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
