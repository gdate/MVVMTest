//
//  UserDetailCell.swift
//  MVPTest
//
//  Created by teda on 2019/12/09.
//  Copyright © 2019 gdate. All rights reserved.
//

import UIKit

final class UserDetailCell: UITableViewCell {
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryLanguage: UILabel!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var falkCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        repositoryName.text = ""
        repositoryDescription.text = ""
        repositoryLanguage.text = ""
        starCount.text = ""
        falkCount.text = ""
    }
    
    func configure(repository: Repository) {
        repositoryName.text = repository.name
        repositoryDescription.text = repository.description
        repositoryLanguage.text = repository.language
        starCount.text = String(repository.star)
        falkCount.text = String(repository.falk)
    }
}
