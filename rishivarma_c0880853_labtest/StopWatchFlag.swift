//
//  StopWatchFlag.swift
//  rishivarma_c0880853_labtest
//
//  Created by RISHI VARMA on 2022-11-04.
//

import UIKit

class StopWatchFlag : UITableViewCell {
    

    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var timeDifference: UILabel!
    @IBOutlet weak var flagTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
