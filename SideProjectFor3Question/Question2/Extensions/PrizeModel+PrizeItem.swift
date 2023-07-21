import Foundation

extension PrizeModel {
    var prizeItem: PrizeItem {
        PrizeItem(name: name, quantity: quantity, probability: probability)
    }
}
