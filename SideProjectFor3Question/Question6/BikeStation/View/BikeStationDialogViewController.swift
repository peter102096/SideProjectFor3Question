import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BikeStationDialogViewController: UIViewController {
    lazy var dialogView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.mainColor?.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.addSubview(stationNameLabel)
        stationNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.centerX.equalToSuperview().priority(1000)
            $0.leading.greaterThanOrEqualToSuperview().inset(16)
            $0.trailing.greaterThanOrEqualToSuperview().inset(16)
            
        }
        view.addSubview(updateTimeLabel)
        updateTimeLabel.snp.makeConstraints {
            $0.top.equalTo(stationNameLabel.snp.bottom).inset(-6)
            $0.leading.trailing.equalTo(stationNameLabel)
        }
        view.addSubview(totalSeatLabel)
        totalSeatLabel.snp.makeConstraints {
            $0.top.equalTo(updateTimeLabel.snp.bottom).inset(-6)
            $0.leading.trailing.equalTo(stationNameLabel)
        }
        view.addSubview(remainingSeatLabel)
        remainingSeatLabel.snp.makeConstraints {
            $0.top.equalTo(totalSeatLabel.snp.bottom).inset(-6)
            $0.leading.trailing.equalTo(stationNameLabel)
        }
        view.addSubview(loactionButton)
        loactionButton.snp.makeConstraints {
            $0.top.equalTo(remainingSeatLabel.snp.bottom).inset(-6)
            $0.leading.trailing.equalTo(stationNameLabel)
            $0.height.equalTo(36)
            $0.bottom.equalToSuperview().inset(36)
        }
        return view
    }()
    //站名 sna
    lazy var stationNameLabel: UILabel = {
        UILabel()
            .setNumberOfLines(0)
            .setText(stationName)
            .setFont(.boldSystemFont(ofSize: 21))
            .setTextColor(.mainColor)
            .setTextAlignment(.left)
            .setLineBreakMode(.byTruncatingTail)
    }()
    //最後更新時間 updateTime
    lazy var updateTimeLabel: UILabel = {
        UILabel()
            .setText(updateTime)
            .setFont(.boldSystemFont(ofSize: 14))
            .setTextColor(.lightGray)
            .setTextAlignment(.left)
    }()
    //可以停的數量 bemp
    lazy var totalSeatLabel: UILabel = {
        UILabel()
            .setText("可以停 \(bemp) 台")
            .setFont(.systemFont(ofSize: 17))
            .setTextColor(.darkGray)
            .setTextAlignment(.left)
    }()
    //可以借的數量 sbi
    lazy var remainingSeatLabel: UILabel = {
        UILabel()
            .setText("可租借剩餘 \(sbi) 台")
            .setFont(.systemFont(ofSize: 17))
            .setTextColor(.red)
            .setTextAlignment(.left)
    }()
    //站名地址描述 ar
    lazy var loactionButton: UIButton = {
        UIButton()
            .setImage(.mapIcon)
            .setTitleColor(.black)
            .setContentMode(.scaleAspectFit)
    }()

    var stationName: String = ""
    var updateTime: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    var bemp: Int = 0
    var sbi: Int = 0

    let disposeBag = DisposeBag()

    convenience init(_ model: YouBike2_0Model) {
        self.init()
        debugPrint(self.classForCoder, "model: \(model)")
        self.stationName = model.sna
        self.updateTime = model.updateTime
        self.lat = model.lat
        self.lng = model.lng
        self.bemp = model.bemp
        self.sbi = model.sbi
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingUI()
    }
    func setupUI() {
        view.backgroundColor = .dialogBgColor
        view.addSubview(dialogView)
        dialogView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.top.greaterThanOrEqualTo(16)
            $0.bottom.lessThanOrEqualTo(16)
        }
    }
    func bindingUI() {
        view.rx.tap
            .bind { [unowned self] in
                dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        loactionButton.rx.tap
            .bind { [unowned self] in
                openGoogleMap()
            }
            .disposed(by: disposeBag)
    }
    func openGoogleMap() {
        let urlString = "comgooglemaps://?center=\(lat),\(lng)&zoom=14&q=\(lat),\(lng)"
        
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            debugPrint(self.classForCoder, "canOpenURL")
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            debugPrint(self.classForCoder, "use webview")
            let googleMapWebURLString = "https://www.google.com/maps?q=\(lat),\(lng)&z=14"
            if let webURL = URL(string: googleMapWebURLString) {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }
}
