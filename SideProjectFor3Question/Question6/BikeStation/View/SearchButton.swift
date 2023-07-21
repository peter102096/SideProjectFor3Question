import UIKit
import SnapKit

class SearchButton: UIButton {
    private let iconImgView = UIImageView(image: .searchIcon)
    private let titleTxtLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setSearchBtnImage(_ image: UIImage?) {
        iconImgView.image = image
    }
    func setSearchBtnImgContentMode(_ contentMode: UIView.ContentMode) {
        iconImgView.contentMode = contentMode
    }
    func setSearchBtnTitle(_ title: String?) {
        titleTxtLabel.text = title
    }
    func setSearchBtnFont(_ font: UIFont?) {
        titleTxtLabel.font = font
    }
    func setSearchBtnTintColor(_ color: UIColor?) {
        titleTxtLabel.textColor = color
        iconImgView.tintColor = color
    }
    private func setupUI() {
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
        backgroundColor = .lightGrayColor
        addSubview(iconImgView)
        iconImgView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(10)
            $0.bottom.lessThanOrEqualTo(-10)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
        titleTxtLabel.text = "搜尋站點"
        titleTxtLabel.textColor = .lightGray
        iconImgView.tintColor = .lightGray
        titleTxtLabel.font = UIFont.systemFont(ofSize: 18)
        addSubview(titleTxtLabel)
        titleTxtLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(10)
            $0.bottom.lessThanOrEqualTo(-10)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(iconImgView.snp.leading).inset(-8)
        }
    }
}
