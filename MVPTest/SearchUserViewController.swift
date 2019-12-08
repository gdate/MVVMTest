//
//  SearchUserViewController.swift
//  MVPTest
//
//  Created by teda on 2019/12/08.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var presenter: SearchUserPresenterInput!
    
    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inject(presenter: SearchUserPresenter(view: self, model: SearchUserModel()))
        tableView.registerCell(type: SearchUserCell.self)
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: SearchUserCell.self, indexPath: indexPath)
        guard let user = presenter.user(forRow: indexPath.row) else { return cell }
        cell.configure(user: user)
        return cell
    }
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    func updateUsers(_ users: [User]) {
        tableView.reloadData()
    }
    
    func transitionToUserDetail(userName: String) {
//        let userDetailVC = UIStoryboard(name: "UserDetail",
//                                        bundle: nil)
//            .instantiateInitialViewController() as! UserDetailViewController
//        let model = UserDetailModel(userName: userName)
//        let presenter = UserDetailPresenter(
//            userName: userName,
//            view: userDetailVC,
//            model: model)
//        userDetailVC.inject(presenter: presenter)
//        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
