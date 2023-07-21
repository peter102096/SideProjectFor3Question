import Foundation
//抽抽樂總共有五種獎項, 1,2 獎各只有一個, 3 獎有 3 個，4 獎有 5 個，5 獎有 9 個，請寫出一個程式可以「隨機」的取得「不重複」的禮物，
//    且：
//    1 獎中獎機率為 0.1%
//    2 獎中獎機率為 3%
//    3 獎中獎機率為 13%
//    4 獎中獎機率為 18%
//    5 獎中獎機率為 25%
class Question2Model: NSObject {
    internal var prizeResponseModel: PrizeResponseModel = .init(prize: [])
    override init() {
        super.init()
        debugPrint(self.classForCoder, "init")
        prizeResponseModel = getPrizeResponse()
    }

    deinit {
        debugPrint(self.classForCoder, "deinit")
    }
    
    func makeAnswer() -> String {
        
        var awardsIndex: [String: [Int]] = [:]
        var total = 0
        if prizeResponseModel.prize.count > 0 {
            while hasRemainingPrizes {
                total += 1
                let randomValue = Double.random(in: 0...1)
                for (index, item) in prizeResponseModel.prize.enumerated() {
                    if randomValue < item.probability, prizeResponseModel.prize[index].quantity > 0 {
                        prizeResponseModel.prize[index].quantity -= 1
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
            for item in prizeResponseModel.prize {
                guard let index = awardsIndex[item.name] else { fatalError("Sorry, get something error !!") }
                var indexString = "\(index)"
                indexString.removeAll(where: { $0 == "[" || $0 == "]" })
                answer.append("抽中\(item.name)的次數落在\n第\(indexString)次\n")
            }
            return answer
        } else {
            fatalError("Sorry, get something error !!")
        }
    }
    private func getPrizeResponse() -> PrizeResponseModel {
        guard let url = Bundle(for: Question2Model.self).url(forResource: "AwardResponse.json", withExtension: nil) else { return .init(prize: []) }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(PrizeResponseModel.self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

