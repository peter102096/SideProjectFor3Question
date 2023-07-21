struct PrizeResponseModel: Codable {
    var prize: [PrizeModel]
    enum CodingKeys: String, CodingKey {
        case prize = "award"
    }
    public init(prize: [PrizeModel]) {
        self.prize = prize
    }
}

struct PrizeModel: Codable {
    let name: String
    var quantity: Int
    let probability: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case quantity
        case probability
    }
    public init(name: String, quantity: Int, probability: Double) {
        self.name = name
        self.quantity = quantity
        self.probability = probability
    }
}
