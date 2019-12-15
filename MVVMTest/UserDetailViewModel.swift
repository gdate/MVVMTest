//
//  UserDetailViewModel.swift
//  MVVMTest
//
//  Created by teda on 2019/12/15.
//  Copyright © 2019 gdate. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class UserDetailViewModel {
    let state = BehaviorRelay<[Repository]?>(value: nil)
    private let model: UserDetailModel
    private let disposeBag = DisposeBag()
    
    init(model: UserDetailModel) {
        self.model = model
    }
    
    func load(query: String) {
        model.fetch(query: query)
            .asObservable()
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}
