//
//  Networking.swift
//  Youtube_Demo
//
//  Created by Duc Canh on 01/08/2023.
//

import Foundation
import RxSwift

struct InformationError: Codable {
    let status: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case status, message
    }
}

struct ErrorFromServer: Codable {
    let error: InformationError
}
enum NetworkError: Error, LocalizedError {
    case general(error: Error)
    case notInternet
    case notDecodeForResult
    case errorFromServer(error: ErrorFromServer)

    var errorDescription: String {
        switch self {
        case .general(error: let error):
            return error.localizedDescription
        case .notInternet:
            return "No Internet"
        case .notDecodeForResult:
            return "Not decode data from server"
        case .errorFromServer(error: let error):
            return error.error.message
        }
    }

    var statusCode: Int? {
        switch self {
        case .errorFromServer(error: let error):
            return error.error.status
        default:
            return nil
        }
    }
}

protocol RequestAPI {
    func request<T: Decodable>(with router: NetworkRouter) -> Observable<T>
}

class Networking: RequestAPI {

    var loadingIndicator: LoadingFeature = LoadingIndicator()

    func request<T: Decodable>(with router: NetworkRouter) -> Observable<T> {
        // Show loading
        if router.isLoading {
            self.loadingIndicator.startLoading()
        }
        return Observable.create { observer in
            let baseUrl = router.baseURL
            let path = router.path
            var stringUrl = baseUrl + path
            // Thêm query vào trong url
            if let querys = router.query {

                for (index, query) in querys.enumerated() {
                    if index == 0 {
                        stringUrl += "?\(query.key)=\(query.value)"
                    } else {
                        stringUrl += "&\(query.key)=\(query.value)"
                    }
                }
            }
            if let url = URL(string: stringUrl) {
                var request = URLRequest(url: url)
                request.httpMethod = router.httpMethod.rawValue
                router.httpHeader.forEach { header in
                    switch header {
                    case .authentication(token: let token):
                        if let token = token {
                            print("Token", token)
                            request.setValue(token, forHTTPHeaderField: header.key)
                        }
                    case .contentType(value: let value):
                        request.setValue(value, forHTTPHeaderField: header.key)
                    }
                }

                if let timeOut = router.timeOut {
                    request.timeoutInterval = TimeInterval(timeOut)
                }

                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let httpResponse = response as? HTTPURLResponse {
                        let code = httpResponse.statusCode
                        if let error = error {
                            print("🆘 error when call api: \(error)\nStatusCode: \(code)")
                            self.loadingIndicator.stopLoading()
                            observer.onError(NetworkError.general(error: error))
                        }

                        if let data = data {
                            if (200...299).contains(code) {
                                do {
                                    let result = try JSONDecoder().decode(T.self, from: data)
                                    print("---------------response ---------------")
                                    print("URL: \(url)" +
                                            "\nMethod: \(router.httpMethod.rawValue)" +
                                            "\nStatusCode: \(code)" +
                                            "\nResult:\n\(result)")
                                    print("---------------response---------------")
                                    observer.onNext(result)
                                    self.loadingIndicator.stopLoading()
                                } catch {
                                    self.loadingIndicator.stopLoading()
                                    observer.onError(NetworkError.notDecodeForResult)
                                }
                            } else {
                                do {
                                    let responseError = try JSONDecoder().decode(ErrorFromServer.self, from: data)
                                    print("🆘 call api fail with response", responseError)
                                    observer.onError(NetworkError.errorFromServer(error: responseError))

                                } catch {
                                    print("🆘 not decode ErrorFromServer")
                                    self.loadingIndicator.stopLoading()
                                    observer.onError(NetworkError.notDecodeForResult)
                                }
                            }
                        }
                    }
                }.resume()

            }

            return Disposables.create()
        }
    }

}

extension ObservableType {
    func getNetworkError() -> Observable<NetworkError> {
        materialize()
            .map({$0.error as? NetworkError})
            .compactMap({$0})
    }

    func getDescriptionError() -> Observable<String> {
        return getNetworkError().map({$0.errorDescription})
    }

    func getStatusCode() -> Observable<Int?> {
        return getNetworkError().map({$0.statusCode})
    }
}
