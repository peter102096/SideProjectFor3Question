import UIKit
import RxSwift

public extension UIViewController {
    func pushViewController(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    func popToViewController(_ vc: UIViewController) {
        navigationController?.popToViewController(vc, animated: true)
    }
}
