//
//  RequestApi.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/5/22.
//

import Foundation

struct BookmarkDto: Decodable, Hashable {
    let title: String
    let url: String
}

class RequestApi: ObservableObject {
    static let shared = RequestApi()
    private init() { }
    @Published var result = [BookmarkDto]()
    
    func fetchData() { // TODO: api 정리
        guard let url = URL(string: "https://jess.loca.lt/v1/bookmarks") else { return }
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode([BookmarkDto].self, from: data)
                DispatchQueue.main.async {
                    self.result = apiResponse
                }
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
        task.resume()
    }
}
