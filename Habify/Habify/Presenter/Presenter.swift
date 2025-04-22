import UIKit

protocol PresenterProtocol: AnyObject {
    func login(_ user: User)
    func register(_ user: User)
}

final class Presenter: PresenterProtocol {
    func login(_ user: User) {
        print("login pressed")
    }
    
    func register(_ user: User) {
        print("register pressed")
    }
}
