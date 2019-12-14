//
//  UserDetailViewController.swift
//  MVPTest
//
//  Created by teda on 2019/12/09.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit

final class UserDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var presenter: UserDetailPresenterInput!
    
    func inject(presenter: UserDetailPresenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(type: UserDetailCell.self)
        presenter.loadView()
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepositories
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: UserDetailCell.self, indexPath: indexPath)
        guard let repository = presenter.repository(forRow: indexPath.row) else { return cell }
        cell.configure(repository: repository)
        return cell
    }
}

extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
}

extension UserDetailViewController: UserDetailPresenterOutput {
    func loadData(_ repositories: [Repository]) {
        tableView.reloadData()
    }
}
