import UIKit

protocol IntroductionViewDelegate: AnyObject {
    func loginPressed()
    func createAccountPressed()
}

final class IntroductionView: UIView {
    
    weak var delegate: IntroductionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        let atrtibutedText = NSMutableAttributedString(string: Constants.Texts.termsText)
        atrtibutedText.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: Constants.Colors.mainBlue],
                                     range: NSRange(location: 0, length: Constants.Texts.termsText.count))
        label.attributedText = atrtibutedText
        label.tag = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(termPressed))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        let atrtibutedText = NSMutableAttributedString(string: Constants.Texts.privacyText)
        atrtibutedText.addAttributes([
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: Constants.Colors.mainBlue],
                                     range: NSRange(location: 0, length: Constants.Texts.privacyText.count))
        label.attributedText = atrtibutedText
        label.tag = 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(privacyPressed))
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private let delimiter: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.Colors.mainBlue
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    
    @objc
    private func termPressed() {
        guard let url = URL(string: Constants.Urls.termsUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc
    private func privacyPressed() {
        guard let url = URL(string: Constants.Urls.privacyUrl) else { return }
        UIApplication.shared.open(url)
    }
    
    private let citation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.Texts.deviz
        label.font = UIFont(name: "Futura", size: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
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
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private lazy var registrationButton: LoginRegistrationButton = {
        let button = LoginRegistrationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.buttonLabel = Constants.Texts.createAccountText
        button.buttonColor = Constants.Colors.mainBlue
        button.tag = 2
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private func setupView() {
        self.backgroundColor = Constants.Colors.mainBackground
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(mainLabel)
        self.addSubview(tempLogo)
        self.addSubview(citation)
        self.addSubview(loginButton)
        self.addSubview(registrationButton)
        self.addSubview(termsLabel)
        self.addSubview(delimiter)
        self.addSubview(privacyLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            tempLogo.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            tempLogo.widthAnchor.constraint(equalToConstant: 200),
            tempLogo.heightAnchor.constraint(equalToConstant: 200),
            tempLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            citation.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            citation.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: registrationButton.topAnchor, constant: -20),
            
            registrationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            registrationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            registrationButton.bottomAnchor.constraint(equalTo: termsLabel.topAnchor, constant: -20),
            
            delimiter.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            delimiter.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            termsLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            termsLabel.trailingAnchor.constraint(equalTo: delimiter.leadingAnchor, constant: -5),
            
            privacyLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            privacyLabel.leadingAnchor.constraint(equalTo: delimiter.trailingAnchor, constant: 5)
        ])
    }
    
    @objc
    private func loginButtonPressed(_ sender: UIButton) {
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
                delegate?.loginPressed()
            } else {
                delegate?.createAccountPressed()
            }
        }
    }
}
