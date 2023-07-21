import Foundation

public typealias YouBike2_0ResponseModel = [YouBike2_0Model]

public struct YouBike2_0Model: Codable {
    let sno: String
    let sna: String
    let tot: Int
    let sbi: Int
    let sarea: String
    let mday: String
    let lat: Double
    let lng: Double
    let ar: String
    let sareaen: String
    let snaen: String
    let aren: String
    let bemp: Int
    let act: String
    let srcUpdateTime: String
    let updateTime: String
    let infoTime: String
    let infoDate: String
    enum CodingKeys: String, CodingKey {
        case sno
        case sna
        case tot
        case sbi
        case sarea
        case mday
        case lat
        case lng
        case ar
        case sareaen
        case snaen
        case aren
        case bemp
        case act
        case srcUpdateTime
        case updateTime
        case infoTime
        case infoDate
    }
    public init(sno: String, sna: String, tot: Int, sbi: Int, sarea: String, mday: String, lat: Double, lng: Double, ar: String, sareaen: String, snaen: String, aren: String, bemp: Int, act: String, srcUpdateTime: String, updateTime: String, infoTime: String, infoDate: String) {
        self.sno = sno
        self.sna = sna
        self.tot = tot
        self.sbi = sbi
        self.sarea = sarea
        self.mday = mday
        self.lat = lat
        self.lng = lng
        self.ar = ar
        self.sareaen = sareaen
        self.snaen = snaen
        self.aren = aren
        self.bemp = bemp
        self.act = act
        self.srcUpdateTime = srcUpdateTime
        self.updateTime = updateTime
        self.infoTime = infoTime
        self.infoDate = infoDate
    }
}


