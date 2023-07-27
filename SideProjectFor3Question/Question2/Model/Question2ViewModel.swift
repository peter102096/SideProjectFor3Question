import Foundation
import RxCocoa
import RxSwift
//抽抽樂總共有五種獎項, 1,2 獎各只有一個, 3 獎有 3 個，4 獎有 5 個，5 獎有 9 個，請寫出一個程式可以「隨機」的取得「不重複」的禮物，
//    且：
//    1 獎中獎機率為 0.1%
//    2 獎中獎機率為 3%
//    3 獎中獎機率為 13%
//    4 獎中獎機率為 18%
//    5 獎中獎機率為 25%
class Question2ViewModel: NSObject, ViewModelType {
    internal var prizeResponseModel: BehaviorRelay<PrizeResponseModel> = .init(value: .init(prize: []))
    private(set) var input: Input!
    private(set) var output: Output!
    
    private let refresh = PublishSubject<Void>()

    override init() {
        super.init()
        debugPrint(self.classForCoder, "init")
        let refresh = refresh.flatMapLatest { [unowned self] in
            makeAnswer()
        }
        input = .init(refresh: self.refresh.asObserver())
        prizeResponseModel = getPrizeResponse()
    }

    deinit {
        debugPrint(self.classForCoder, "deinit")
    }
    
    private func makeAnswer() -> Observable<String> {
        Observable.create { [unowned self] observer in
            var awardsIndex: [String: [Int]] = [:]
            var total = 0
            if prizeResponseModel.value.prize.count > 0 {
                while hasRemainingPrizes {
                    total += 1
                    let randomValue = Double.random(in: 0...1)
                    for (index, item) in prizeResponseModel.value.prize.enumerated() {
                        if randomValue < item.probability, prizeResponseModel.value.prize[index].quantity > 0 {
                            var model = prizeResponseModel.value
                            model.prize[index].quantity -= 1
                            prizeResponseModel.accept(model)
                            if var indexArray = awardsIndex[item.name] {
                                indexArray.append(total)
                                awardsIndex[item.name] = indexArray
                            } else {
                                awardsIndex.updateValue([total], forKey: item.name)
                            }
                            break
                        }
                    }
                }
                var answer = ""
                answer.append("總共抽了: \(total) 次\n")
                for item in prizeResponseModel.value.prize {
                    guard let index = awardsIndex[item.name] else { fatalError("Sorry, get something error !!") }
                    var indexString = "\(index)"
                    indexString.removeAll(where: { $0 == "[" || $0 == "]" })
                    answer.append("抽中\(item.name)的次數落在\n第\(indexString)次\n")
                }
                observer.onNext(answer)
                observer.onCompleted()
            }
            else {
                observer.onError("Sorry, get something error !!" as! Error)
            }
            return Disposables.create()
        }
    }
    private func getPrizeResponse() -> Observable<PrizeResponseModel> {
        Observable.create { observer in
            guard let url = Bundle(for: Question2ViewModel.self).url(forResource: "AwardResponse.json", withExtension: nil) else { return .init(prize: []) }
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode(PrizeResponseModel.self, from: data)
            } catch {
                fatalError(error.localizedDescription)
            }
            return Disposables.create()
        }
    }
}

extension Question2ViewModel {
    struct Input {
        let refresh: AnyObserver<Void>
    }

    struct Output {
        let getPrize: Driver<PrizeResponseModel>
        let getResult: Driver<String>
    }
}
