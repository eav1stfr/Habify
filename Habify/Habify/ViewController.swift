import UIKit

class ViewController: UIViewController {
    typealias CombinedPresenterProtocol = PresenterLoginFunctionalityProtocol & PresenterCreateAccFunctionalityProtocol
    
    var presenter: CombinedPresenterProtocol?
    
    private lazy var introView: IntroductionView = {
        let view = IntroductionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var createAccountView: CreateAccountView = {
        let view = CreateAccountView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(introView)
        setupContraints()
        self.view.backgroundColor = Constants.Colors.mainBackground
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            introView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            introView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            introView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            introView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
}

extension ViewController: IntroductionViewDelegate {
    func loginPressed() {
        print("login pressed")
        UIView.animate(withDuration: 0.2, animations: { [self] in
            introView.alpha = 0
        }, completion: { _ in
            self.introView.removeFromSuperview()
            self.view.addSubview(self.loginView)
            NSLayoutConstraint.activate([
                self.loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.loginView.topAnchor.constraint(equalTo: self.view.topAnchor)
            ])
            self.loginView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: { [self] in
                loginView.alpha = 1.0
            })
        })
    }
    
    func createAccountPressed() {
        print("Create account pressed from introduction view")
        UIView.animate(withDuration: 0.2, animations: { [self] in
            introView.alpha = 0
        }, completion: { _ in
            self.introView.removeFromSuperview()
            self.view.addSubview(self.createAccountView)
            NSLayoutConstraint.activate([
                self.createAccountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.createAccountView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.createAccountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.createAccountView.topAnchor.constraint(equalTo: self.view.topAnchor)
            ])
            self.createAccountView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: { [self] in
                createAccountView.alpha = 1.0
            })
        })
    }
}

extension ViewController: LoginViewDelegate {
    func login(_ username: String, _ password: String) {
        let user = User(username: username, password: password)
        print("login was pressed, received user data")
        print(username, password)
        presenter?.login(user)
    }
    
    func forgotPassword() {
        presenter?.forgotThePassword()
    }
    
    func signUp() {
        UIView.animate(withDuration: 0.2, animations: { [self] in
            loginView.alpha = 0
        }, completion: { _ in
            self.loginView.removeFromSuperview()
            self.view.addSubview(self.createAccountView)
            NSLayoutConstraint.activate([
                self.createAccountView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.createAccountView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.createAccountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.createAccountView.topAnchor.constraint(equalTo: self.view.topAnchor)
            ])
            self.createAccountView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: { [self] in
                createAccountView.alpha = 1.0
            })
        })
    }
    
    func loginWithGoogle() {
        presenter?.loginWithGoogle()
    }
}

extension ViewController: CreateAccountViewDelegate {
    func createAccountFromCreateAccountPressed() {
        
    }
    
    func loginFromCreateAccountViewPressed() {
        UIView.animate(withDuration: 0.2, animations: { [self] in
            createAccountView.alpha = 0
        }, completion: { _ in
            self.createAccountView.removeFromSuperview()
            self.view.addSubview(self.loginView)
            NSLayoutConstraint.activate([
                self.loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                self.loginView.topAnchor.constraint(equalTo: self.view.topAnchor)
            ])
            self.loginView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: { [self] in
                loginView.alpha = 1.0
            })
        })
    }
}
