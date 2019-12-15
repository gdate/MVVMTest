//
//  UserDetailModel.swift
//  MVPTest
//
//  Created by teda on 2019/12/09.
//  Copyright © 2019 gdate. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol UserDetailModelInput {
    func fetchRepository(query: String,completion: @escaping (Result<[Repository], Error>) -> ())
}

final class UserDetailModel: UserDetailModelInput {
    private let mockRepositories = [
        Repository(name: "SugoiLibrary", author: "sato", description: "sugoi", language: "Objective-C", star: 0, falk: 0),
        Repository(name: "YabaiLibrary", author: "sato", description: "yabai", language: "Swift", star: 0, falk: 0),
        Repository(name: "TanakaLibrary", author: "sato", description: "tanaka", language: "Swift", star: 0, falk: 0),
        Repository(name: "KudasaiStar", author: "sato", description: "sugoi", language: "Swift", star: 0, falk: 0),
        Repository(name: "YamadaLibrary", author: "sato", description: "hoge", language: "Swift", star: 92, falk: 3),
        Repository(name: "InoueLibrary", author: "sato", description: "foo", language: "Swift", star: 67, falk: 2),
        Repository(name: "YamadaLibrary", author: "yamada", description: "hoge", language: "Swift", star: 100000, falk: 1000),
        Repository(name: "InoueLibrary", author: "inoue", description: "foo", language: "Swift", star: 3000, falk: 18)
    ]
    
    func fetchRepository(query: String, completion: @escaping (Result<[Repository], Error>) -> ()) {
        let match: [Repository] = mockRepositories.reduce(into: []) { (result, repository) in
            if repository.author == query {
                result.append(repository)
            }
        }
        
        return match.isEmpty ? completion(.failure(ErrorType.general)) : completion(.success(match))
    }
}

extension UserDetailModel {
    enum ErrorType: Int, Error {
        case general
    }
    
    func fetch(query: String) -> Single<[Repository]> {
        return Single<[Repository]>.create { [unowned self] singleEvent in
            self.fetchRepository(query: query) { result in
                switch result {
                case .success(let value):
                    singleEvent(.success(value))
                case .failure(let error):
                    singleEvent(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
