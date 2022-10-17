
import Foundation

// MARK: - Welcome
struct User: Codable {
    var user: UserInfo?
    var token: String?
}

// MARK: - User
struct UserInfo: Codable {
    var name, email, phone, updatedAt: String?
    var createdAt: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
