//
//  NetworkManager.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import Foundation
import Alamofire

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    private init() { }
    
    func makeUrl(url: String = Config.baseURL, path: String) -> URL? {
        return URL(string: url + path)
    }
    
    func request(url: URL?,
                 method: HTTPMethod = .get,
                 params: Parameters? = nil,
                 onSuccess: @escaping (Data) -> Void,
                 onFailure: @escaping (Error) -> Void) {
        
        guard let url = url else { return }
        AF.request(url, method: method, parameters: params)
            .validate()
            .responseData { response in
                switch response.result {
                case .success (let data):
                    do {
                        var jsonDict: [String: Any]?
                        jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let jsonDict = jsonDict {
                            print("\(String(describing: jsonDict))")
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                    onSuccess(data)
                case .failure (let error):
                    print("Error: \(error)")
                    onFailure(error)
                }
            }.resume()
    }
}
