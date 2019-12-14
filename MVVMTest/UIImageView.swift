//
//  UIImageView.swift
//  MVPTest
//
//  Created by teda on 2019/12/08.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit

extension UIImageView {
    public func setImage(url: String?) {
        guard let urlString = url, let _url = URL(string: urlString), let data = try? Data(contentsOf: _url) else { return }
        image = UIImage(data: data)
    }
}
