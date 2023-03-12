import UIKit

final class UsersResponse: BaseResponse {
    let page: Int?
    let perPage: Int?
    let total: Int?
    let totalPages: Int?
    let data: [User]?
    let support: Support?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case perPage = "perPage"
        case total = "total"
        case totalPages = "totalPages"
        case data = "data"
        case support = "support"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try? container.decode(Int.self, forKey: .page)
        perPage = try? container.decode(Int.self, forKey: .perPage)
        total = try? container.decode(Int.self, forKey: .total)
        totalPages = try? container.decode(Int.self, forKey: .totalPages)
        data = try? container.decode([User].self, forKey: .data)
        support = try? container.decode(Support.self, forKey: .support)
        
        try super.init(from: decoder)
    }
}

final class User: Codable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
}

final class Support: Codable {
    let url: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case text = "text"
    }
}
