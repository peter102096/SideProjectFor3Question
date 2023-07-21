import UIKit

extension UIButton {
    @discardableResult
    public func setTitle(_ title: String?) -> Self {
        setTitle(title, for: .normal)
        return self
    }

    @discardableResult
    public func setTitleColor(_ color: UIColor?) -> Self {
        setTitleColor(color, for: .normal)
        return self
    }

    @discardableResult
    public func setImage(_ image: UIImage?) -> Self {
        setImage(image, for: .normal)
        return self
    }
    @discardableResult
    public func setContentMode(_ mode: UIView.ContentMode) -> Self {
        self.imageView?.contentMode = mode
        return self
    }
}
