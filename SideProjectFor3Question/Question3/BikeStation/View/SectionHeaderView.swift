import UIKit
import SnapKit

class SectionHeaderView: UITableViewHeaderFooterView {

    let countyLabel = {
        UILabel()
            .setText("縣市")
            .setTextColor(.white)
            .setFont(.systemFont(ofSize: 24))
            .setTextAlignment(.center)
            .setBackgroundColor(.clear)
    }()
    let areaLabel = {
        UILabel()
            .setText("區域")
            .setTextColor(.white)
            .setFont(.systemFont(ofSize: 24))
            .setTextAlignment(.center)
            .setBackgroundColor(.clear)
    }()
    let stationNameLabel = {
        UILabel()
            .setText("站點名稱")
            .setTextColor(.white)
            .setFont(.systemFont(ofSize: 24))
            .setTextAlignment(.center)
            .setBackgroundColor(.clear)
    }()
    
    override func draw(_ rect: CGRect) {
        let view = UIView(frame: rect)
        view.backgroundColor = .mainColor
        addSubview(view)
        view.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        view.addSubview(countyLabel)
        countyLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(rect.width*0.2)
        }
        view.addSubview(areaLabel)
        areaLabel.snp.makeConstraints {
            $0.leading.equalTo(countyLabel.snp.trailing).inset(-12)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(rect.width*0.2)
        }
        view.addSubview(stationNameLabel)
        stationNameLabel.snp.makeConstraints {
            $0.leading.equalTo(areaLabel.snp.trailing).inset(-12)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
