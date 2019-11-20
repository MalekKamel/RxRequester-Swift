//
// Created by Sha on 2019-03-02.
// Copyright (c) 2019 A. All rights reserved.
//

import UIKit


class PostCell: UITableViewCell {

    var item: Post! {
        didSet { setup() }
    }

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var btnMore: UIButton!

     private func setup() {
        lblTitle.text = item.title
        lblBody.text = item.body
        lblName.text = "Sha"
        lblTime.text = "4m"
    }
}
