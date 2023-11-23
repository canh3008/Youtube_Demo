//
//  NetworkRouter.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPHeader {
    case authentication(token: String?)
    case contentType(value: String)

    var key: String {
        switch self {
        case .authentication:
            return "Authorization"
        case .contentType:
            return "Content-Type"
        }
    }
}

enum MultipleRequest {
    case files
    case images
}

protocol RequestForConnect {
    var httpMethod: HTTPMethod {get}
    var path: String {get}
    var baseURL: String {get}
    var httpHeader: [HTTPHeader] {get}
    var multipleRequest: MultipleRequest? {get}
    var bearerToken: String? {get}
    var timeOut: Int? {get}
    var query: [String: Any]? {get}
    var isLoading: Bool {get}
}

enum NetworkRouter: RequestForConnect {
    // home
    case getVideos
    enum QueryKey: String {
        case limit
        case seedGenres = "seed_genres"
    }
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getVideos:
            return "/home.json"
        }
    }

    var baseURL: String {
        switch self {
        default:
            return Constants.baseURL
        }

    }

    var httpHeader: [HTTPHeader] {
        switch self {
        case .getVideos:
            return [.contentType(value: "application/json")]
//        default:
//            return [.contentType(value: "application/json"),
//                    .authentication(token: bearerToken)]
        }
    }

    var multipleRequest: MultipleRequest? {
        switch self {
        default:
            return nil
        }
    }

    var bearerToken: String? {
        guard let token = UserDefaults.standard.string(forKey: "key") else {
            return nil
        }
        return "Bearer \(token)"
    }

    var timeOut: Int? {
        switch self {
        default:
            return nil
        }
    }

    var query: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }

    var isLoading: Bool {
        switch self {
        default:
            return true
        }
    }
}
