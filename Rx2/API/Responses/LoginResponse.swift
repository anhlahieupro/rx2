import UIKit

final class LoginResponse: BaseResponse {
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        token = try? container.decode(String.self, forKey: .token)
        
        try super.init(from: decoder)
    }
}
