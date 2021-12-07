//
//  APIService.swift
//  TawkTest
//
//  Created by JayR- Mac-mini on 8/30/21.
//

import Foundation
import Moya

// MARK: - Provider setup
private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

let apiServiceProvider = MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))])

// MARK: - Provider support
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum APIService {
    case userProfile(String)
    case userList(Int)
}

extension APIService: TargetType {
    public var baseURL: URL { return URL(string: "https://api.github.com")! }
    public var path: String {
        switch self {
        case .userProfile(let name):
            return "/users/\(name.urlEscaped)"
        case .userList(_):
            return "/users"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    public var task: Task {
        switch self {
        case .userList(let lastUserId):
                return .requestParameters(parameters: ["since": lastUserId], encoding: URLEncoding.default)
            default:
                return .requestPlain
        }
    }
    public var validationType: ValidationType {
        return .none
    }
    public var sampleData: Data {
        switch self {
        case .userProfile(_):
            guard let url = Bundle.main.url(forResource: "profile", withExtension: "json"),
                        let data = try? Data(contentsOf: url) else {
                            return Data()
                    }
                    return data
        case .userList(_):
            guard let url = Bundle.main.url(forResource: "list", withExtension: "json"),
                        let data = try? Data(contentsOf: url) else {
                            return Data()
                    }
                    return data
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

// MARK: - Response Handlers
extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}
