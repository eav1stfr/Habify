import Foundation

struct UserToRegister: Codable {
    var fullName: String
    var email: String
    var username: String
    var password: String
}

struct User: Codable {
    var username: String
    var password: String
}
