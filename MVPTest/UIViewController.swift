//
//  UIViewController.swift
//  MVPTest
//
//  Created by teda on 2019/12/09.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiate<T: UIViewController>(type: T.Type) -> T {
        let className = String(describing: T.self)
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className) as! T
    }
}
