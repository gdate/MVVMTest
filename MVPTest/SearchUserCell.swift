//
//  SearchUserCell.swift
//  MVPTest
//
//  Created by teda on 2019/12/08.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit

final class SearchUserCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userName.text = ""
    }
    
    func configure(user: User) {
        userName.text = user.name
        userImage.setImage(url: user.image.absoluteString)
    }
}
