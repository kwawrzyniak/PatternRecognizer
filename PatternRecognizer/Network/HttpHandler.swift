//
//  HttpHandler.swift
//  PatternRecognizer
//
//  Created by Karol Wawrzyniak on 26/07/2018.
//  Copyright © 2018 KAWA. All rights reserved.
//

import Foundation
import UIKit
import Unbox

public typealias CompletionBlock<T> = (T?, Error?) -> Void

protocol HttpHandlerRequest {

    func endPoint() -> String

    func method() -> String

    func parameters() -> Dictionary<String, Any>?

    func headers() -> Dictionary<String, String>

}

public enum HTTPHandlerError: Error {

    case WrongStatusCode(message: String?)

    case ServerResponseNotParseable(message: String?)

    case NotHttpResponse(message: String?)

    case NoDataFromServer

    case NotExpetedDatastructureFromServer(message: String?)

    case ServerResponseIsNotUnboxableDictionary(message: String?)

    case ServerReportedUnsuccessfulOperation

}

extension HTTPHandlerError: LocalizedError {

    private func concatMessage(error: String, message: String?) -> String {

        var result = error

        if let m = message {
            result.append(" : ")
            result.append(m)
        }

        return result
    }

    public var errorDescription: String? {
        switch self {

        case .NotHttpResponse(message: let message):

            return concatMessage(error: "Not http response".localized, message: message)

        case .WrongStatusCode(message: let message):

            return concatMessage(error: "Wrong http status code".localized, message: message)

        case .ServerResponseNotParseable(message: let message):

            return concatMessage(error: "Bad server response - not parsable".localized, message: message)

        case .NoDataFromServer:
            return "No data from server".localized

        case .NotExpetedDatastructureFromServer(message: let message):

            return concatMessage(error: "Not expected data structure from server".localized, message: message)

        case .ServerResponseIsNotUnboxableDictionary(message: let message):

            return concatMessage(error: "Server response is not unboxable".localized, message: message)

        case .ServerReportedUnsuccessfulOperation:
            return "Server reported unsuccessful operation".localized
        }
    }

}

protocol HttpHandler: class {

    var baseURL: String { get }

    var urlSession: URLSession { get }
    func make<T>(request: HttpHandlerRequest, completion: @escaping (T?, Error?) -> Void)
    func make<T: Unboxable>(request: HttpHandlerRequest, completion: @escaping (T?, Error?) -> Void)

}

class HTTPHandlerImpl: HttpHandler {

    var urlSession: URLSession
    let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
        self.urlSession = URLSession(configuration: .default)
    }

    fileprivate func handleResponse<T>(_ error: Error?, _ response: HTTPURLResponse, _ data: Data?, completion: @escaping (T?, Error?) -> Void) {
        DispatchQueue.main.async {
            if error != nil {
                completion(nil, error)
                return
            }

            if let dataToParse = data {

                guard response.statusCode == 200 else {
                    completion(nil, HTTPHandlerError.WrongStatusCode(message: response.debugDescription))
                    return
                }

                guard let parsedData = try? JSONSerialization.jsonObject(with: dataToParse) else {
                    let jsonString = String(data: dataToParse, encoding: String.Encoding.utf8)
                    completion(nil, HTTPHandlerError.ServerResponseNotParseable(message: jsonString))
                    return
                }

                if let parsedData = parsedData as? T {
                    completion(parsedData, error)
                } else {
                    let jsonString = String(data: dataToParse, encoding: String.Encoding.utf8)
                    completion(nil, HTTPHandlerError.ServerResponseNotParseable(message: jsonString))
                }

            } else {
                completion(nil, HTTPHandlerError.NoDataFromServer)
            }
        }
    }

    static var numberOfCallsToSetVisible: Int = 0

    static func setVisibleActivitiIndicator(visible: Bool) {
        if visible {
            HTTPHandlerImpl.numberOfCallsToSetVisible = HTTPHandlerImpl.numberOfCallsToSetVisible + 1
        } else {
            HTTPHandlerImpl.numberOfCallsToSetVisible = HTTPHandlerImpl.numberOfCallsToSetVisible - 1
        }

        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = HTTPHandlerImpl.numberOfCallsToSetVisible > 0
        }
    }

    func make<T: Unboxable>(request: HttpHandlerRequest, completion: @escaping (T?, Error?) -> Void) {

        self.run(request: request) { (result: UnboxableDictionary?, error: Error?) in

            if let error = error {
                completion(nil, error)
                return
            }
            guard let result = result else {
                completion(nil, HTTPHandlerError.ServerResponseNotParseable(message: "Something went wrong".localized))
                return
            }
            do {
                let unboxed: T = try unbox(dictionary: result)
                completion(unboxed, nil)
            } catch let error {
                completion(nil, error)
            }

        }
    }

    func run<T>(request: HttpHandlerRequest, completion: @escaping (T?, Error?) -> Void) {

        guard let url = URL(string: self.baseURL + request.endPoint()) else { return }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        urlRequest.httpMethod = request.method()

        let headers = request.headers()

        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        if let params = request.parameters(), request.method() != "GET" {
            do {
                let paramsData = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions(rawValue: 0))
                urlRequest.httpBody = paramsData
            } catch let error {
                completion(nil, error)
            }
        }

        HTTPHandlerImpl.setVisibleActivitiIndicator(visible: true)

        let task = self.urlSession.dataTask(with: urlRequest) { [weak self] (data, pResponse, error) in

            HTTPHandlerImpl.setVisibleActivitiIndicator(visible: false)

            guard let `self` = self else {
                return
            }

            guard let response = pResponse as? HTTPURLResponse else {

                if let error = error {
                    completion(nil, error)
                } else {
                    let responseInfo = pResponse.debugDescription
                    completion(nil, HTTPHandlerError.NotHttpResponse(message: responseInfo))
                }

                return
            }

            self.handleResponse(error, response, data, completion: completion)

        }

        task.resume()
    }

    func make<T>(request: HttpHandlerRequest, completion: @escaping (T?, Error?) -> Void) {
        self.run(request: request, completion: completion)
    }

}
