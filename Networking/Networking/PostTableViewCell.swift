//
//  PostTableViewCell.swift
//  Networking
//
//  Created by Валентина Лінчук on 27/09/2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ post: Post) {
        postLabel.text = post.title
        postBodyLabel.text = post.body
    }
    
}
