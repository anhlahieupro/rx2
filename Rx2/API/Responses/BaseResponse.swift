import UIKit

class BaseResponse: Codable {
    var code: Int?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case error = "error"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try? container.decode(Int.self, forKey: .code)
        error = try? container.decode(String.self, forKey: .error)
    }
}
