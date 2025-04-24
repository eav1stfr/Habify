import UIKit

protocol LoginViewDelegate: AnyObject {
    func login(_ username: String, _ password: String)
    func forgotPassword()
    func signUp()
    func loginWithGoogle()
}

final class LoginView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: LoginViewDelegate?
    
    private let underlineOne: Delimiter = {
        let view = Delimiter()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let underlineTwo: Delimiter = {
        let view = Delimiter()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.appName
        label.textColor = Constants.Colors.mainBlue
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "bird")
        image.tintColor = Constants.Colors.mainBlue
        image.clipsToBounds = true
        image.backgroundColor = Constants.Colors.mainBackground
        return image
    }()
    
    private lazy var loginButton: LoginRegistrationButton = {
        let button = LoginRegistrationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonLabel = Constants.Texts.loginText
        button.buttonColor = Constants.Colors.mainBlue
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let googleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Texts.loginWithGoogle
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let googleLogo: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(named: "GoogleLogo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return image
    }()
    
    private lazy var stackGoogle: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 10
        stack.axis = .horizontal
        stack.addArrangedSubview(googleLogo)
        stack.addArrangedSubview(googleLabel)
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private lazy var loginWithGoogleButton: LoginRegistrationButton = {
        let button = LoginRegistrationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(stackGoogle)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        button.backgroundColor = Constants.Colors.mainBlue
        NSLayoutConstraint.activate([
            stackGoogle.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stackGoogle.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        button.tag = 2
        return button
    }()
    
    private lazy var usernameField: TextField = {
        let field = TextField()
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.placeholderLabel = "Username"
        return field
    }()
    
    private lazy var passwordField: TextField = {
        let field = TextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholderLabel = "Password"
        field.delegate = self
        field.isSecureTextEntry = true
        return field
    }()
    
    private let dontHaveAccLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Texts.dontHaveAccountText
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = Constants.Colors.mainBlue
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Texts.signUpText, for: .normal)
        button.setTitleColor(Constants.Colors.mainBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Texts.orText
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = Constants.Colors.mainBlue
        return label
    }()
    
    @objc
    private func signUpPressed(_ sender: UIButton) {
        delegate?.signUp()
    }
    
    @objc
    private func loginPressed(_ sender: UIButton) {
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
        group.notify(queue: .main) { [self] in
            switch sender.tag {
            case 1:
                guard let username = usernameField.text else { return }
                guard let password = passwordField.text else { return }
                print(username, password)
                delegate?.login(username, password)
                break
            case 2:
                delegate?.loginWithGoogle()
                break
            default:
                delegate?.signUp()
            }
        }
    }
    
    private func setupView() {
        self.backgroundColor = Constants.Colors.mainBackground
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(mainLabel)
        self.addSubview(tempLogo)
        self.addSubview(usernameField)
        self.addSubview(underlineOne)
        self.addSubview(passwordField)
        self.addSubview(underlineTwo)
        self.addSubview(loginButton)
        self.addSubview(orLabel)
        self.addSubview(loginWithGoogleButton)
        self.addSubview(stack)
        
        stack.addArrangedSubview(dontHaveAccLabel)
        stack.addArrangedSubview(signUpButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tempLogo.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            tempLogo.widthAnchor.constraint(equalToConstant: 200),
            tempLogo.heightAnchor.constraint(equalToConstant: 200),
            tempLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            usernameField.topAnchor.constraint(equalTo: tempLogo.bottomAnchor, constant: 60),
            usernameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            usernameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            underlineOne.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 2),
            underlineOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            underlineOne.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            passwordField.topAnchor.constraint(equalTo: underlineOne.bottomAnchor, constant: 25),
            passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            underlineTwo.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 2),
            underlineTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            underlineTwo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: orLabel.topAnchor, constant: -10),
            
            orLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            orLabel.bottomAnchor.constraint(equalTo: loginWithGoogleButton.topAnchor, constant: -10),
            
            loginWithGoogleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginWithGoogleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginWithGoogleButton.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -20),
            
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
