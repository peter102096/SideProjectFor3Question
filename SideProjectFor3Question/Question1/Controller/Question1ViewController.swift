import UIKit
import RxSwift

class Question1ViewController: UIViewController {
    lazy var answerView: UITextView = {
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
    lazy var inputTxt: UITextField = {
       UITextField()
            .setText("\(Int.random(in: 0...Int.max))")
            .setKeyboardType(.numberPad)
            .setBackgroundColor(.white)
            .setTextColor(.black)
            .setBorderStyle(.roundedRect)
    }()
    lazy var calculatorBtn = {
        UIButton()
            .setTitle("Calculate")
            .setTitleColor(.black)
    }()
    lazy var randomRetryBtn = {
        UIButton()
            .setTitle("Random Number Retry")
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
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        overrideUserInterfaceStyle = .light
    }

    func bindingUI() {
        randomRetryBtn.rx.tap
            .bind { [unowned self] in
                inputTxt.text = "\(Int.random(in: 0...Int.max))"
                getAnswer()
            }
            .disposed(by: disposeBag)
        calculatorBtn.rx.tap
            .bind { [unowned self] in
                getAnswer()
            }
            .disposed(by: disposeBag)
        inputTxt.rx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [unowned self] text in
                getAnswer()
            })
            .disposed(by: disposeBag)
    }

    func setupUI() {
        view.addSubview(answerView)
        answerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(view.bounds.height * 0.5)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        view.addSubview(inputTxt)
        inputTxt.snp.makeConstraints {
            $0.bottom.equalTo(answerView.snp.top).inset(-24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        view.addSubview(randomRetryBtn)
        randomRetryBtn.snp.makeConstraints {
            $0.top.equalTo(answerView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        view.addSubview(calculatorBtn)
        calculatorBtn.snp.makeConstraints {
            $0.top.equalTo(randomRetryBtn.snp.bottom)
            $0.bottom.lessThanOrEqualTo(16)
            $0.centerX.equalToSuperview()
        }
    }

    func getAnswer() {
        guard let number = Int(inputTxt.text ?? "0") else { return }
        var answer = ""
        answer.append("測試數字為: \n\(number)\n")
        answer.append(measureExecutionTime {
            answer.append("Answer: \n\(Question1Model().makeAnswer(number: number))\n")
        })
        answerView.text = answer
    }
}
