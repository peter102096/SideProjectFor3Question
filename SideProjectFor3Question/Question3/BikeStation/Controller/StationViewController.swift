import UIKit
import SnapKit
import RxCocoa
import RxSwift
import JGProgressHUD

class StationViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        UILabel()
            .setFont(.boldSystemFont(ofSize: 24))
            .setTextColor(.mainColor)
            .setText(titleTxt)
    }()
    lazy var searchBtn: SearchButton = {
        SearchButton()
    }()

    lazy var sectionHeaderHeight: CGFloat = {
        70
    }()
    lazy var bikeTableView: UITableView = {
        UITableView()
            .setRegister(UINib(nibName: "BikeTableViewCell", bundle: nil), forCellReuseIdentifier: "BikeTableViewCell")
            .setRegister(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
            .setSectionHeaderHeight(sectionHeaderHeight)
            .setSectionHeaderTopPadding(0)
            .setBorderColor(UIColor.lightGray.cgColor)
            .setBorderWidth(1)
            .setCornerRadius(10)
            .setDataSource(self)
            .setDelegate(self)
            .setSeparatorStyle(.none)
    }()

    lazy var dropDownMenu: UITableView = {
        UITableView()
            .setHiddenState(true)
            .setRegister(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            .setSeparatorStyle(.none)
            .setSectionHeaderTopPadding(0)
            .setCornerRadius(10)
            .setDelegate(self)
            .setDataSource(self)
            .setBackgroundColor(.lightGrayColor)
            .setSeparatorInset(.init(top: 16, left: 10, bottom: 16, right: 10))
    }()

    private var titleTxt = ""

    let loadingView = JGProgressHUD(style: .extraLight)

    var menuLastSelectedIndex: IndexPath? = nil

    let model = StationModel()

    let refreshControl = UIRefreshControl()

    let disposeBag = DisposeBag()

    convenience init(_ vcType: Question3VCType) {
        self.init()
        debugPrint(self.classForCoder, "init, type: \(vcType.rawValue)")
        titleTxt = vcType.rawValue
    }

    deinit {
        debugPrint(self.classForCoder, "deinit, type: \(titleTxt)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(self.classForCoder, "viewDidLoad")
        setupUI()
        bindingUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingData()
    }

    func setupUI() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        view.addSubview(searchBtn)
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-12)
            $0.leading.trailing.equalTo(titleLabel)
        }
        view.addSubview(bikeTableView)
        bikeTableView.snp.makeConstraints {
            $0.top.equalTo(searchBtn.snp.bottom).inset(-12)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(dropDownMenu)
        dropDownMenu.snp.makeConstraints {
            $0.top.equalTo(searchBtn.snp.bottom).inset(-12)
            $0.leading.trailing.equalTo(titleLabel)
            $0.height.equalTo(view.bounds.height * 0.3)
        }
    }
    func bindingUI() {
        bikeTableView.refreshControl = refreshControl
        let refreshTrigger = refreshControl.rx.controlEvent(.valueChanged).asObservable()
        refreshTrigger
            .subscribe(onNext: { [unowned self] in
                loadingData()
            })
            .disposed(by: disposeBag)

        searchBtn.rx.tap
            .bind { [unowned self] in
                if dropDownMenu.isHidden {
                    showMenu()
                } else {
                    dismissMenu()
                }
                
            }
            .disposed(by: disposeBag)
    }
    func menuDidSelected(_ name: String) {
        model.filterStation(name)
        searchBtn.setSearchBtnTitle(name)
        bikeTableView.reloadData()
        bikeTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    func showMenu() {
        dropDownMenu.setHiddenState(false)
        searchBtn.setSearchBtnTintColor(.mainColor)
    }
    func dismissMenu() {
        dropDownMenu.setHiddenState(true)
        searchBtn.setSearchBtnTintColor(.lightGray)
    }
    func showDialog(_ model: YouBike2_0Model) {
        let vc = BikeStationDialogViewController(model)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async { [unowned self] in
            present(vc, animated: true, completion: nil)
        }
    }
    func loadingData() {
        DispatchQueue.main.async { [unowned self] in
            loadingView.show(in: view)
            model.getStation { [unowned self]  state in
                loadingView.dismiss()
                refreshControl.endRefreshing()
                if state {
                    bikeTableView.reloadData()
                    dropDownMenu.reloadData()
                    if menuLastSelectedIndex != nil {
                        dropDownMenu.selectRow(at: menuLastSelectedIndex, animated: false, scrollPosition: .middle)
                        tableView(dropDownMenu, didSelectRowAt: menuLastSelectedIndex!)
                    }
                } else {
                    return
                }
            }
        }
    }
}
