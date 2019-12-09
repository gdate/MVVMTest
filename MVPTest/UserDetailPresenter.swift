//
//  UserDetailPresenter.swift
//  MVPTest
//
//  Created by teda on 2019/12/09.
//  Copyright © 2019 gdate. All rights reserved.
//

import Foundation

protocol UserDetailPresenterInput {
    var numberOfRepositories: Int { get }
    func repository(forRow row: Int) -> Repository?
    func loadView()
}

protocol UserDetailPresenterOutput: AnyObject {
    func loadData(_ repositories: [Repository])
}

final class UserDetailPresenter: UserDetailPresenterInput {
    private(set) var repositories: [Repository] = []
    private weak var view: UserDetailPresenterOutput!
    private var model: UserDetailModelInput
    private var userName: String
    
    init(userName: String, view: UserDetailPresenterOutput, model: UserDetailModelInput) {
        self.userName = userName
        self.view = view
        self.model = model
    }
    
    var numberOfRepositories: Int {
        return repositories.count
    }
    
    func repository(forRow row: Int) -> Repository? {
        guard row < repositories.count else { return nil }
        return repositories[row]
    }
    
    func loadView() {
        model.fetchRepository(query: userName) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.view.loadData(repositories)
                }
            case .failure:
                ()
            }
        }
    }
}
