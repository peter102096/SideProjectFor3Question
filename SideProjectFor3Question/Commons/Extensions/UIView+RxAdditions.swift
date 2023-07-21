import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    // 创建一个新的 ControlEvent，用于处理点击事件
    var tap: ControlEvent<Void> {
        // 通过 UITapGestureRecognizer 创建一个 ControlEvent
        let tapGestureRecognizer = UITapGestureRecognizer()
        base.addGestureRecognizer(tapGestureRecognizer)
        base.isUserInteractionEnabled = true
        
        return ControlEvent(events: tapGestureRecognizer.rx.event.map { _ in })
    }
}
