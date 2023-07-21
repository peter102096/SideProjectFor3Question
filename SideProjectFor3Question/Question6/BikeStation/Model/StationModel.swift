import UIKit

class StationModel: NSObject {
    
    private var totalResult: YouBike2_0ResponseModel = []
    private(set) var result: YouBike2_0ResponseModel = []
    private var uniqueSarea: Set<String> = []
    private(set) var sareas: [String] = []
    private var filter: String = ""

    override init() {
        super.init()
        debugPrint(self, "init")
    }

    deinit {
        debugPrint(self, "deinit")
    }

    func getStation(completion: @escaping (Bool) -> Void) {
        API.shared.getStation { [weak self] statusCode, result in
            guard let self = self else {
                completion(false)
                fatalError("something error")
            }
            if result is YouBike2_0ResponseModel, statusCode != 404 {
                self.totalResult = result as! YouBike2_0ResponseModel
                self.result = self.totalResult
                if filter != "" {
                    filterStation(filter)
                }
                for station in self.result {
                    self.uniqueSarea.insert(station.sarea)
                }
                self.sareas = Array(self.uniqueSarea)
                self.sareas.sort()
                self.sareas.insert("全部", at: 0)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    func filterStation(_ name: String) {
        if name == "全部" {
            filter = ""
            result = totalResult
        } else {
            filter = name
            result = totalResult.filter { $0.sarea == name }
        }
    }
}
