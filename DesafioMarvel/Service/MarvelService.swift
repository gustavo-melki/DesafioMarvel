import Foundation
import Moya
import RxSwift
import CryptoSwift

fileprivate struct MarvelAPIConfig {
  
  static let privatekey = "0e3b6a4ba5dd54e8361b849efce73639fe337edb"
  static let apikey = "ab7c2f12650fe730f24dca8a85fc49f4"
  static let ts = Date().timeIntervalSince1970.description
  static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

enum MarvelService {
  case characters
  case showUser(id: Int)
  case createUser(firstName: String, lastName: String)
  case updateUser(id: Int, firstName: String, lastName: String)
  case showAccounts
}

extension MarvelService: TargetType {
  var baseURL: URL { return URL(string: "https://gateway.marvel.com:443/v1/public")! }
  var path: String {
    switch self {
    case .characters:
      return "/characters"
    case .showUser(let id), .updateUser(let id, _, _):
      return "/users/\(id)"
    case .createUser(_, _):
      return "/users"
    case .showAccounts:
      return "/accounts"
    }
  }
  var method: Moya.Method {
    switch self {
    case .characters, .showUser, .showAccounts:
      return .get
    case .createUser, .updateUser:
      return .post
    }
  }
  
  func authParameters() -> [String: String] {
    return ["apikey": MarvelAPIConfig.apikey,
            "ts": MarvelAPIConfig.ts,
            "hash": MarvelAPIConfig.hash]
  }
  
  var task: Task {
    
    switch self {
    case .characters, .showUser, .showAccounts: // Send no parameters
      return .requestParameters(parameters: authParameters(), encoding: URLEncoding.queryString)
      
    case let .updateUser(_, firstName, lastName):  // Always sends parameters in URL, regardless of which HTTP method is used
      return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: URLEncoding.queryString)
    case let .createUser(firstName, lastName): // Always send parameters as JSON in request body
      return .requestParameters(parameters: ["first_name": firstName, "last_name": lastName], encoding: JSONEncoding.default)
    }
  }
  var sampleData: Data {
    switch self {
    case .characters:
      return "".utf8Encoded
    case .showUser(let id):
      return "{\"id\": \(id), \"first_name\": \"Harry\", \"last_name\": \"Potter\"}".utf8Encoded
    case .createUser(let firstName, let lastName):
      return "{\"id\": 100, \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
    case .updateUser(let id, let firstName, let lastName):
      return "{\"id\": \(id), \"first_name\": \"\(firstName)\", \"last_name\": \"\(lastName)\"}".utf8Encoded
    case .showAccounts:
      // Provided you have a file named accounts.json in your bundle.
      guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json"),
        let data = try? Data(contentsOf: url) else {
          return Data()
      }
      return data
    }
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
// MARK: - Helpers
private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}

