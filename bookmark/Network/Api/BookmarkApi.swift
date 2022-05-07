//
//  BookmarkApi.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import Foundation

class BookmarkApi {
    let network = NetworkManager.shared
    
    func getBookmarks(_ completion: @escaping ([BookmarkDto]) -> Void) {
        guard let url = network.makeUrl(path: "/v1/bookmarks") else { return }
        network.request(url: url) { data in
            do {
                let response = try JSONDecoder().decode([BookmarkDto].self, from: data)
                completion(response)
            } catch (let error) {
                print(error.localizedDescription)
            }
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    func postBookmark(folderId: Int, title: String, strUrl: String, _ completion: @escaping () -> Void) {
        guard let url = network.makeUrl(path: "/v1/bookmarks") else { return }
        let params: [String: Any] = [
            "folderId": folderId,
            "title": title,
            "url": strUrl,
        ]
        network.request(url: url, method: .post, params: params) { _ in
            completion()
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    //    TODO: 바꾸기
    //    @escaping (Result<T, Error>) -> Void
    //    completion(.success(response))
    //    completion(.failure(error))
}
