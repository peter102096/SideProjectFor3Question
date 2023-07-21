import UIKit
import SnapKit
import RxSwift
import RxCocoa

class Question2ViewController: UIViewController {
    
    lazy var answerView = {
        UITextView()
            .setTextAlignment(.left)
            .setBackgroundColor(.white)
            .setTextColor(.black)
            .setFont(.systemFont(ofSize: 21))
            .isEditable(false)
            .setBorderColor(UIColor.lightGray.cgColor)
            .setBorderWidth(1)
            .setCornerRadius(10)
    }()
    lazy var retryBtn = {
        UIButton()
            .setTitle("Retry")
            .setTitleColor(.black)
    }()

    let disposeBag = DisposeBag()

    deinit {
        debugPrint(self.classForCoder, "deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(.white)
        bindingUI()
        setupUI()
        getAnswer()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func bindingUI() {
        retryBtn.rx.tap
            .bind { [unowned self] in
                getAnswer()
            }
            .disposed(by: disposeBag)
    }
    func setupUI() {
        view.addSubview(answerView)
        answerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(view.bounds.height * 0.5)
        }
        view.addSubview(retryBtn)
        retryBtn.snp.makeConstraints {
            $0.top.equalTo(answerView.snp.bottom).inset(-16)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
        }
    }
    func getAnswer() {
        var answer = ""
        answer.append(measureExecutionTime {
            answer.append("\(Question2Model().makeAnswer())\n")
        })
        answerView.text = answer
    }
}
