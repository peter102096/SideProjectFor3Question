import UIKit
import SnapKit
import RxCocoa
import RxSwift

class OtherViewController: UIViewController {

    lazy var titleLabel = {
        UILabel()
            .setText(titleTxt)
            .setTextColor(.black)
    }()

    private var titleTxt = ""
    
    convenience init(_ vcType: Question6VCType) {
        self.init()
        debugPrint(self.classForCoder, "init, type: \(vcType.rawValue)")
        titleTxt = vcType.rawValue
    }

    deinit {
        debugPrint(self.classForCoder, "deinit, type: \(titleTxt)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(.white)
        setupUI()
    }
    func setupUI() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
