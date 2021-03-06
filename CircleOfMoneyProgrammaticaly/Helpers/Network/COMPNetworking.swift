//
//  COMPNetworking.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 4.03.21.
//

import Foundation
import Alamofire

class COMPNetworking {
    // MARK: - Static
    static let shared = COMPNetworking()

    // MARK: - Variables
    private let baseUrl: String = "https://v6.exchangerate-api.com/v6/"

    private let apiKey: String = "059ab2356f6790cea3423ee4"

    private lazy var session = URLSession(configuration: .default)

    private lazy var parameters: [String: String] = [
        "api_key": self.apiKey
    ]

    // MARK: - For Alamofire Framework
    private let sessionManager: Alamofire.Session

    // MARK: - Init
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60

        // Alamofire
        self.sessionManager = Session.default
    }

    // MARK: - Methods
    func request<Generic: Decodable>(url: String,
                                     currency: String,
                                     successHandler: @escaping (Generic) -> Void,
                                     errorHandler: @escaping (COMPNetworkError) -> Void) {

        let fullUrl = baseUrl + apiKey + currency

        let request = URLRequest(url: URL(string: fullUrl) ?? URL(string: "https://v6.exchangerate-api.com/v6/b8cf407191ff9a2a81cde6e9/latest/USD")!)

        let dataTask = self.session.dataTask(with: request) { data, response, error in

            if let error: Error = error {
                DispatchQueue.main.async {
                    errorHandler(.networkError(error: error))
                }
                return
            } else if let data: Data = data,
                      let response: HTTPURLResponse = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    // Success server response handling
                    do {
                        let model = try JSONDecoder().decode(Generic.self, from: data)
                        DispatchQueue.main.async {
                            successHandler(model)
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            errorHandler(.parsingError(error: error))
                        }
                    }
                case 400..<500:
                    // TODO: - response model error handling
                    break
                case 500...:
                    // Handle server errors
                    DispatchQueue.main.async {
                        errorHandler(.serverError(statusCode: response.statusCode))
                    }
                default:
                    // Handle every unknown error
                    DispatchQueue.main.async {
                        errorHandler(.unknown)
                    }
                }
            }
        }
        dataTask.resume()
    }

    func requestAlamofire<Generic: Decodable>(url: String,
                                              currency: String,
                                              successHandler: @escaping (Generic) -> Void,
                                              errorHandler: @escaping (COMPNetworkError) -> Void) {

        guard let fullUrl = URL(string: baseUrl + apiKey + currency) else { return }

        self.sessionManager
            .request(fullUrl)
            .responseJSON(completionHandler: { (response) in
                if let error = response.error {
                    // Network error handling
                    errorHandler(.networkError(error: error))
                    return
                } else if let data = response.data,
                          let httpResponse = response.response {
                    switch httpResponse.statusCode {
                    case 200..<300:
                        // Success server response handling
                        do {
                            let model = try JSONDecoder().decode(Generic.self, from: data)
                            successHandler(model)
                        } catch let error {
                            errorHandler(.parsingError(error: error))
                        }
                    case 400..<500:
                        // TODO: - response model error handling
                        break
                    case 500...:
                        // Handle server errors
                        errorHandler(.serverError(statusCode: httpResponse.statusCode))
                    default:
                        // Handle every unknown error
                        errorHandler(.unknown)
                    }
                }
            })
    }
}

