import UIKit
extension UITextView {
    @discardableResult
    public func setText(_ text: String?) -> Self {
        self.text = text
        return self
    }
    @discardableResult
    public func setTextColor(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    @discardableResult
    func setTextAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    @discardableResult
    public func setFont(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    @discardableResult
    public func isEditable(_ enable: Bool) -> Self {
        self.isEditable = enable
        return self
    }
}
