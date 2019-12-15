//
//  UserDetailViewController.swift
//  MVPTest
//
//  Created by teda on 2019/12/09.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class UserDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: UserDetailViewModel!
    private let disposeBag = DisposeBag()
    private var dependency: Dependency!
    
    struct Dependency {
        let model: UserDetailModel
        let query: String
    }
    
    func inject(dependency: Dependency) {
        self.dependency = dependency
        self.viewModel = UserDetailViewModel(model: dependency.model)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCell(type: UserDetailCell.self)
        
        viewModel.state.subscribe(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.load(query: dependency.query)
    }
}

extension UserDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = viewModel.state.value else { return 0 }
        return state.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: UserDetailCell.self, indexPath: indexPath)
        guard let state = viewModel.state.value else { return cell }
        cell.configure(repository: state[indexPath.row])
        return cell
    }
}

extension UserDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
}
