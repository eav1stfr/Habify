import Foundation

struct UserToRegister: Codable {
    var fullName: String
    var dateOfBirth: String
    var username: String
    var password: String
}

struct User: Codable {
    var username: String
    var password: String
}
