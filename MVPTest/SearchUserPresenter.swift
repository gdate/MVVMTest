//
//  SearchUserPresenter.swift
//  MVPTest
//
//  Created by teda on 2019/12/08.
//  Copyright © 2019 gdate. All rights reserved.
//

import Foundation

protocol SearchUserPresenterInput {
    var numberOfUsers: Int { get }
    func user(forRow row: Int) -> User?
    func didSelectRow(at indexPath: IndexPath)
    func didTapSearchButton(text: String?)
}

protocol SearchUserPresenterOutput: AnyObject {
    func updateUsers(_ users: [User])
    func transitionToUserDetail(userName: String)
}

final class SearchUserPresenter: SearchUserPresenterInput {
    private(set) var users: [User] = []
    private weak var view: SearchUserPresenterOutput!
    private var model: SearchUserModelInput
    
    init(view: SearchUserPresenterOutput, model: SearchUserModelInput) {
        self.view = view
        self.model = model
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forRow row: Int) -> User? {
        guard row < users.count else { return nil }
        return users[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
//        guard let user = user(forRow: indexPath.row) else { return }
//        view.transitionToUserDetail(userName: user.login)
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        guard !query.isEmpty else { return }
        model.fetchUser(query: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                DispatchQueue.main.async {
                    self?.view.updateUsers(users)
                }
            case .failure:
                ()
            }
        }
    }
}
