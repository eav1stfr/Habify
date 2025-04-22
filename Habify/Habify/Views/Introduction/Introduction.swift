import UIKit

final class IntroductionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presenter: PresenterProtocol?
    
    private lazy var loginButton: LoginRegistrationButton = {
        let button = LoginRegistrationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonLabel = "Log In"
        button.buttonColor = UIColor(named: "ThemeColor")!
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private func setupView() {
        self.backgroundColor = UIColor(named: "ButtonColor")
        self.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    @objc
    private func loginButtonPressed(_ sender: UIButton) {
        let user = User(fullName: "alex",
                        dateOfBirth: "bro",
                        username: "bro",
                        password: "hello new world")
        let group = DispatchGroup()
        group.enter()
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: {_ in
            UIView.animate(withDuration: 0.1, animations: {
                sender.transform = CGAffineTransform.identity
            }, completion: {_ in
                group.leave()
            })
        })
        group.notify(queue: .main) {
            self.presenter?.login(user)
        }
    }
}
