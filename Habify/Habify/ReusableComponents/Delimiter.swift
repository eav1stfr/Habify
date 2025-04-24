import UIKit

final class Delimiter: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUnderline()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUnderline() {
        self.backgroundColor = Constants.Colors.mainBlue
        self.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

