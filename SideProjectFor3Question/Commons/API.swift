import UIKit
import Alamofire

class API: NSObject {
    public static let shared = API()
    private let TAG = "API"
    private var trustIP: String = "tcgbusfs.blob.core.windows.net"
    private lazy var sharedSession: Session = {
        let manager = ServerTrustManager(evaluators: [trustIP: DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    var statusCode: Int? = 404

    private override init() {
        super.init()
    }

    public func getStation(completion: @escaping (Int?, Codable?) -> Void) {
        connectToServer(url: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json", dataStruct: YouBike2_0ResponseModel.self, completion: completion)
    }

    public func connectToServer<T: Codable>(url: String, method: HTTPMethod = .get, dataStruct struct: T.Type, params: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, completion: @escaping (Int?, Codable?) -> Void) {
        statusCode = 404
        let headers: HTTPHeaders?

        headers = nil

        sharedSession.request(url, method: method, parameters: params, encoding: encoding, headers: headers).responseDecodable(of: T.self) { [unowned self] (data) in
            statusCode = data.response?.statusCode
            print("statusCode : \(statusCode ?? 9999)")
            switch data.result {
            case .success(_):
                completion(statusCode, data.value)
                break
            case .failure(_):
                print("\(TAG) connectToServer failure")
                if data.error == nil {
                    let errorData = ResultModel(result: "Data decode failed")
                    completion(statusCode, errorData)
                } else {
                    let errorData = ResultModel(result: "\(data.error!.localizedDescription)")
                    completion(statusCode, errorData)
                }
                break
            }
        }
    }
}
