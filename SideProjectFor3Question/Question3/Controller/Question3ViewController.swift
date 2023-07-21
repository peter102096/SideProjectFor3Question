import UIKit
import SnapKit
import RxCocoa
import RxSwift

class Question3ViewController: UIViewController {
    //MARK: UI Componets
    lazy var navigationView: UIView = {
        let view = UIView()
        let imgView =
        UIImageView(image: .ubikeLogo)
            .setContentMode(.scaleAspectFit)
        view.addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.leading.equalToSuperview().inset(6)
        }
        view.addSubview(menuBtn)
        menuBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24)
        }
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(24)
        }
        return view
    }()

    lazy var menuBtn: UIButton = {
        UIButton()
            .setImage(.menuIcon)
            .setContentMode(.scaleAspectFit)
    }()

    lazy var closeBtn: UIButton = {
        UIButton()
            .setImage(.closeIcon)
            .setContentMode(.scaleAspectFit)
            .setHiddenState(true)
    }()

    lazy var dividerLine: UIView = {
        UIView()
            .setBackgroundColor(.mainColor)
    }()

    lazy var menuView: UITableView = {
        UITableView()
            .setBackgroundColor(.mainColor)
            .setHiddenState(true)
            .setSeparatorStyle(.none)
            .setDataSource(self)
            .setDelegate(self)
            .setSeparatorInset(.init(top: 16, left: 16, bottom: 16, right: 16))
            .setRegister(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }()

    lazy var content: UIView = {
        UIView()
            .setBackgroundColor(.white)
    }()

    internal var previousSelectedIndexPath: IndexPath?
    let menuData = Question3VCType.allCases

    let disposeBag = DisposeBag()

    deinit {
        debugPrint(self.classForCoder, "deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(.white)
        setupUI()
        bindingUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaultIndexPath = IndexPath(row: 3, section: 0)
        menuView.selectRow(at: defaultIndexPath, animated: true, scrollPosition: .none)
        tableView(menuView, didSelectRowAt: defaultIndexPath)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    func setupUI() {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        view.addSubview(navigationView)
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(height + 20)
        }
        view.addSubview(dividerLine)
        dividerLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navigationView.snp.bottom)
        }
        view.addSubview(content)
        content.snp.makeConstraints {
            $0.top.equalTo(dividerLine.snp.bottom).inset(-6)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(menuView)
        menuView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(navigationView.snp.bottom)
        }
    }

    func bindingUI() {
        menuBtn.rx.tap
            .bind { [unowned self] in
                menuView.setHiddenState(false)
                menuBtn.setHiddenState(true)
                closeBtn.setHiddenState(false)
            }
            .disposed(by: disposeBag)
        closeBtn.rx.tap
            .bind { [unowned self] in
                menuView.setHiddenState(true)
                menuBtn.setHiddenState(false)
                closeBtn.setHiddenState(true)
            }
            .disposed(by: disposeBag)
    }

    func switchVC(type: Question3VCType) {
        let vc: UIViewController
        switch type {
        case .UseInfo, .Recharge, .News, .Activity:
            vc = OtherViewController(type)
        case .Station:
            vc = StationViewController(type)
        case .Home:
            popViewController()
            return
        }
        _ = children.map { $0.removeFromParent() }
        menuView.setHiddenState(true)
        menuBtn.setHiddenState(false)
        closeBtn.setHiddenState(true)
        addChild(vc)
        vc.view.frame = content.bounds
        content.addSubview(vc.view)
        didMove(toParent: self)
    }
}
