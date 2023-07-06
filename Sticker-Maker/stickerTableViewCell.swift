//
//  stickerTableViewCell.swift
//  Sticker-Maker
//
//  Created by mohammad noor uddin on 6/7/23.
//

import UIKit

class stickerTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
