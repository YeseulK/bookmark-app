//
//  FolderApi.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import Foundation

class FolderApi {
    let network = NetworkManager.shared
    
    func getFolders(_ completion: @escaping ([FolderDto]) -> Void) {
        guard let url = network.makeUrl(path: "/v1/folders") else { return }
        network.request(url: url) { data in
            do {
                let response = try JSONDecoder().decode([FolderDto].self, from: data)
                completion(response)
            } catch (let error) {
                print(error.localizedDescription)
            }
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
    
    func getFolder(folerId: Int, _ completion: @escaping (FolderDto) -> Void) {
        guard let url = network.makeUrl(path: "/v1/folders/\(folerId)") else { return }
        network.request(url: url) { data in
            do {
                let response = try JSONDecoder().decode(FolderDto.self, from: data)
                completion(response)
            } catch (let error) {
                print(error.localizedDescription)
            }
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
}