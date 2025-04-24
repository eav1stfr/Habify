import UIKit

protocol CreateAccountViewDelegate: AnyObject {
    func createAccountFromCreateAccountPressed()
    func loginFromCreateAccountViewPressed()
}

final class CreateAccountView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Constants.Colors.mainBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: CreateAccountViewDelegate?
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.appName
        label.textColor = Constants.Colors.mainBlue
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameField: TextField = {
        let field = TextField()
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.placeholderLabel = Constants.Texts.usernameTextFieldText
        return field
    }()
    
    private lazy var password: TextField = {
        let field = TextField()
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.placeholderLabel = Constants.Texts.passwordTextFieldText
        field.isSecureTextEntry = true
        field.textContentType = .oneTimeCode
        return field
    }()
    
    private lazy var email: TextField = {
        let field = TextField()
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.placeholderLabel = Constants.Texts.emailTextField
        return field
    }()
    
    private lazy var fullName: TextField = {
        let field = TextField()
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.placeholderLabel = Constants.Texts.fullNameTextField
        return field
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
    
    private lazy var createAccountButton: LoginRegistrationButton = {
        let button = LoginRegistrationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonLabel = Constants.Texts.createAccountText
        button.buttonColor = Constants.Colors.mainBlue
        button.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
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
    
    private let underlineThree: Delimiter = {
        let view = Delimiter()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let underlineFour: Delimiter = {
        let view = Delimiter()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let alreadyHaveAcc: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Texts.alreadyHaveAccText
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textColor = Constants.Colors.mainBlue
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Texts.signInText, for: .normal)
        button.setTitleColor(Constants.Colors.mainBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.addTarget(self, action: #selector(createAccountPressed), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(alreadyHaveAcc)
        stack.addArrangedSubview(loginButton)
        return stack
    }()
    
    @objc
    private func createAccountPressed(_ sender: UIButton) {
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
            if sender.tag == 1 {
                delegate?.createAccountFromCreateAccountPressed()
            } else {
                delegate?.loginFromCreateAccountViewPressed()
            }
        }
    }
    
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(mainLabel)
        self.addSubview(tempLogo)
        self.addSubview(fullName)
        self.addSubview(underlineOne)
        self.addSubview(email)
        self.addSubview(underlineTwo)
        self.addSubview(usernameField)
        self.addSubview(underlineThree)
        self.addSubview(password)
        self.addSubview(underlineFour)
        self.addSubview(createAccountButton)
        self.addSubview(stack)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tempLogo.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            tempLogo.widthAnchor.constraint(equalToConstant: 200),
            tempLogo.heightAnchor.constraint(equalToConstant: 200),
            tempLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            fullName.topAnchor.constraint(equalTo: tempLogo.bottomAnchor, constant: 40),
            fullName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            fullName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            underlineOne.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 2),
            underlineOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            underlineOne.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            email.topAnchor.constraint(equalTo: underlineOne.bottomAnchor, constant: 25),
            email.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            email.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            underlineTwo.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 2),
            underlineTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            underlineTwo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            usernameField.topAnchor.constraint(equalTo: underlineTwo.bottomAnchor, constant: 25),
            usernameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            usernameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            underlineThree.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 2),
            underlineThree.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            underlineThree.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            password.topAnchor.constraint(equalTo: underlineThree.bottomAnchor, constant: 25),
            password.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            password.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            underlineFour.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 2),
            underlineFour.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            underlineFour.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            createAccountButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            createAccountButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            createAccountButton.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -20),
            
            stack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

extension CreateAccountView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
