import UIKit

final class LoginRegistrationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var buttonLabel: String = "" {
        didSet {
            self.setTitle(buttonLabel, for: .normal)
        }
    }
    
    var buttonColor: UIColor = .black {
        didSet {
            self.backgroundColor = buttonColor
        }
    }
    
    var buttonAction: Selector? {
        didSet {
            self.addTarget(self, action: buttonAction!, for: .touchUpInside)
        }
    }
    
    private func setupButton() {
        self.layer.cornerRadius = 35
        self.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
