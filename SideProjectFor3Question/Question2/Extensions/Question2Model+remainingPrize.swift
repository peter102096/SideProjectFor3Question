extension Question2ViewModel {
    var remainingPrize: String {
        var description = ""
        for (index, item) in prizeResponseModel.prize.enumerated() {
            description.append("\(item.name): \(item.quantity)")
            if index < prizeResponseModel.prize.count - 1 {
                description.append(", ")
            }
        }
        return description
    }
    var hasRemainingPrizes: Bool {
        prizeResponseModel.prize.contains { $0.quantity > 0 }
    }
}
