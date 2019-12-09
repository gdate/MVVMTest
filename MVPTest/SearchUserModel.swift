//
//  SearchUserModel.swift
//  MVPTest
//
//  Created by teda on 2019/12/08.
//  Copyright © 2019 gdate. All rights reserved.
//

import Foundation

protocol SearchUserModelInput {
    func fetchUser(query: String,completion: @escaping (Result<[User], Error>) -> ())
}

final class SearchUserModel: SearchUserModelInput {
    private let mockUsers = [
        User(name: "sato", image: URL(string: "https://illustrain.com/img/work/2016/illustrain09-neko9.png")!),
        User(name: "yamada", image: URL(string:"https://illustrain.com/img/work/2016/illustrain02-cat29.png")!),
        User(name: "inoue", image: URL(string:"https://illustrain.com/img/work/2016/illustrain02-cat10.png")!)
    ]
    
    func fetchUser(query: String, completion: @escaping (Result<[User], Error>) -> ()) {
        let match: [User] = mockUsers.reduce(into: []) { (result, user) in
            if user.name == query {
                result.append(user)
            }
        }
        
        return match.isEmpty ? completion(.failure(ErrorType.general)) : completion(.success(match))
    }
}

extension SearchUserModel {
    enum ErrorType: Int, Error {
        case general
    }
}
