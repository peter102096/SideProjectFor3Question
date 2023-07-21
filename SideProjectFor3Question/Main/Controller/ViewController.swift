import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    lazy var stackView = {
        UIStackView(arrangedSubviews: [question1Btn, question2Btn, question6Btn])
            .setAxis(.vertical)
            .setAlignment(.center)
            .setDistribution(.fillEqually)
    }()
    
    lazy var question1Btn: UIButton = {
        UIButton()
            .setTitle("Question1")
            .setTitleColor(.black)
    }()
    lazy var question2Btn: UIButton = {
        UIButton()
            .setTitle("Question2")
            .setTitleColor(.black)
    }()
    lazy var question6Btn: UIButton = {
        UIButton()
            .setTitle("Question6")
            .setTitleColor(.black)
    }()

    let disposeBag = DisposeBag()
    
    deinit {
        debugPrint(self.classForCoder, "deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupUI()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func setupUI() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.greaterThanOrEqualTo(16)
            $0.bottom.lessThanOrEqualTo(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
    }
    func bindingUI() {
        question1Btn.rx.tap
            .bind(onNext: { [unowned self] in
                pushViewController(Question1ViewController())
            })
            .disposed(by: disposeBag)

        question2Btn.rx.tap
            .bind(onNext: { [unowned self] in
                pushViewController(Question2ViewController())
            })
            .disposed(by: disposeBag)

        question6Btn.rx.tap
            .bind(onNext: { [unowned self] in
                pushViewController(Question6ViewController())
            })
            .disposed(by: disposeBag)
    }
}

