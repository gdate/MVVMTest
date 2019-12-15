//
//  SearchUserViewController.swift
//  MVPTest
//
//  Created by teda on 2019/12/08.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class SearchUserViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SearchUserViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SearchUserViewModel(model: SearchUserModel())
        tableView.registerCell(type: SearchUserCell.self)
        
        viewModel.state.subscribe(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        viewModel.search(query: query)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = viewModel.state.value else { return 0 }
        return state.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: SearchUserCell.self, indexPath: indexPath)
        guard let state = viewModel.state.value else { return cell }
        cell.configure(user: state[indexPath.row])
        return cell
    }
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let state = viewModel.state.value else { return }
        let userDetailViewController = UserDetailViewController.instantiate(type: UserDetailViewController.self)
        userDetailViewController.inject(dependency: .init(model: UserDetailModel(), query: state[indexPath.row].name))
        navigationController?.pushViewController(userDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}
