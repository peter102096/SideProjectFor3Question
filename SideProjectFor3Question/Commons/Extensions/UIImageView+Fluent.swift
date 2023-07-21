import Foundation
import UIKit

extension UIImageView {
    @discardableResult
    public func setContentMode(_ mode: UIView.ContentMode) -> Self {
        self.contentMode = mode
        return self
    }
}
