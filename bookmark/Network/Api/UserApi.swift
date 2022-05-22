//
//  UserApi.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/22/22.
//

import Foundation

class UserApi {
    let network = NetworkManager.shared
    
    func login(email: String, password: String, _ completion: @escaping () -> Void) {
        guard let url = network.makeUrl(path: "/v1/members/login") else { return }
        let params: [String: Any] = [
            "email": email,
            "password": password
        ]
        network.request(url: url, method: .post, params: params) { data in
            Config.token = String(data: data, encoding: .utf8) ?? ""
            completion()
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
}
