//
//  AllAnimalTableViewCell.swift
//  sesi3-peer
//
//  Created by Dony Prastiya on 24/03/23.
//

import UIKit

class AllAnimalTableViewCell: UITableViewCell {
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
