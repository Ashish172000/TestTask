//
//  HttpUtility.swift
//  AsyncAwaitDemo
//
//  Created by CodeCat15 on 11/15/21.
//

import Foundation
import UIKit
enum httpError : Error {
    case jsonDecoding
    case noData
    case nonSuccessStatusCode
    case serverError
    case emptyCollection
    case emptyObject
}
enum ApiEndpoint {
    case getPost
    case getComment(Int32)
   enum Method: String {
      case GET
      case POST
      case PUT
      case DELETE
   }
}
extension ApiEndpoint {
    
    var path: String {
         switch self {
         case .getPost:
             return "/posts"
         case .getComment(let id):
             return "/posts/\(id)/comments"
         }
      }
    
    var method: ApiEndpoint.Method {
          switch self {
          default:
             return .GET
          }
       }
    
    var queryItem: [URLQueryItem]? {
          switch self {
          default:
             return nil
          }
       }
    var body: Codable? {
        switch self {
        default:
            return nil
        }
    }
    var header: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
}



final class HttpUtility {

    static let shared: HttpUtility = HttpUtility()
    private init() {}
    var baseUrl = "https://jsonplaceholder.typicode.com"
    func performOperation<T:Decodable>(request: ApiEndpoint, response: T.Type,
                                       completionHandler:
                                       @escaping(T?, Error?)->Void) {
        let stringUrl = baseUrl + request.path
        var urlRequest = URLRequest(url: URL(string: stringUrl)!)
        urlRequest.httpMethod = request.method.rawValue
        if let requestBody = request.body {
            do {
                let requestBody = try JSONEncoder().encode(requestBody)
                urlRequest.httpBody = requestBody
            } catch {
                print(error.localizedDescription)
            }
        }
        if let header = request.header {
            urlRequest.allHTTPHeaderFields = header
        }
        URLSession.shared.dataTask(with: urlRequest) { serverData, serverResponse, serverError in

            guard serverError == nil else { return completionHandler(nil,httpError.serverError) }
            guard let httpStausCode = (serverResponse as? HTTPURLResponse)?.statusCode,
                  (200...299).contains(httpStausCode) else {
                      return completionHandler(nil, httpError.nonSuccessStatusCode)
                  }
            guard serverData?.isEmpty == false else {
                return completionHandler(nil,httpError.noData)

            }
            do {
                let result = try JSONDecoder().decode(response.self, from: serverData!)
                completionHandler(result,nil)
            } catch {
                completionHandler(nil,error)
            }
        }.resume()
    }
}
