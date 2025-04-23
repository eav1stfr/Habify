import UIKit

final class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var placeholderLabel: String = "" {
        didSet {
            self.placeholder = placeholderLabel
        }
    }
    
    let underline: CALayer = {
        let line = CALayer()
        return line
    }()
    
    private func setupTextField() {
        self.borderStyle = .none
        self.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.textColor = Constants.Colors.mainBlue
    }
}
