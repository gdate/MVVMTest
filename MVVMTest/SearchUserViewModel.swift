//
//  SearchUserViewModel.swift
//  MVVMTest
//
//  Created by teda on 2019/12/14.
//  Copyright © 2019 gdate. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchUserViewModel {
    let state = BehaviorRelay<[User]?>(value: nil)
    private let model: SearchUserModel
    private let disposeBag = DisposeBag()
    
    init(model: SearchUserModel) {
        self.model = model
    }
    
    func search(query: String) {
        model.fetch(query: query)
            .asObservable()
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}
