import UIKit

protocol PresenterLoginFunctionalityProtocol: AnyObject {
    func login(_ user: User)
    func loginWithGoogle()
    func forgotThePassword()
}

protocol PresenterCreateAccFunctionalityProtocol: AnyObject {
    func register(_ user: UserToRegister)
}

final class Presenter: PresenterLoginFunctionalityProtocol, PresenterCreateAccFunctionalityProtocol {
    func login(_ user: User) {
        print("login pressed")
    }
    
    func register(_ user: UserToRegister) {
        print("register pressed")
    }
    
    func loginWithGoogle() {
        print("login with google from presenter")
    }
    
    func forgotThePassword() {
        print("forgot the password from the presenter")
    }
}

final class GoogleAuthHandler {
    
}
