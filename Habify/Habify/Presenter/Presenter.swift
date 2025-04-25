import UIKit
import FirebaseAuth

protocol PresenterLoginFunctionalityProtocol: AnyObject {
    func login(_ user: User)
    func loginWithGoogle()
    func forgotThePassword()
    func createAccount(_ user: UserToRegister)
}

protocol PresenterCreateAccFunctionalityProtocol: AnyObject {
    func register(_ user: UserToRegister)
}

final class Presenter: PresenterLoginFunctionalityProtocol, PresenterCreateAccFunctionalityProtocol {
    
    func createAccount(_ user: UserToRegister) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                print("there was some error creating an account \(error.localizedDescription)")
            } else {
                print("User signed up: \(result?.user.email ?? "")")
            }
        }
    }
    
    func login(_ user: User) {
        Auth.auth().signIn(withEmail: user.username, password: user.password) { result, error in
            if let error = error {
                print("Sign up error: \(error.localizedDescription)")
            } else {
                print("User signed up: \(result?.user.email ?? "")")
            }
        }
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
