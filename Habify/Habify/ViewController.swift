import UIKit

class ViewController: UIViewController {
    
    var presenter: PresenterProtocol?
    
    private lazy var introView: IntroductionView = {
        var view = IntroductionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.presenter = self.presenter
        view.delegate = self
        return view
    }()
    
    private lazy var loginView: LoginView = {
        var view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
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
        
    }
}

extension ViewController: LoginViewDelegate {
    func login() {
        print("login was pressed")
    }
    
    func forgotPassword() {
        print("forgot password pressed")
    }
    
    func signUp() {
        print("sign up was pressed")
    }
    
    func loginWithGoogle() {
        print("login with google pressed")
    }
}

