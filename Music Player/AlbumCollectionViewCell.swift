//
//  AlbumCollectionViewCell.swift
//  Music Player
//
//  Created by mohammad noor uddin on 15/6/23.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    @IBOutlet weak var albumTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        albumImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        albumImageView.layer.cornerRadius = 8.0 * (UIScreen.main.bounds.size.width / 393.0)
//        albumImageView.clipsToBounds = true
//        
//        albumTitle.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        albumTitle.layer.cornerRadius = 8.0 * (UIScreen.main.bounds.size.width / 393.0)
//        albumTitle.clipsToBounds = true
        
        albumImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        albumImageView.layer.cornerRadius = 8.0 * (UIScreen.main.bounds.size.width / 393.0)
        albumImageView.clipsToBounds = true

        albumTitle.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        albumTitle.layer.cornerRadius = 8.0 * (UIScreen.main.bounds.size.width / 393.0)
        albumTitle.clipsToBounds = true

        
//        layer.shadowColor = UIColor.lightGray.cgColor
//        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius:(8.0 * (UIScreen.main.bounds.size.width / 414.0))).cgPath
//        layer.shadowRadius = 2
//        layer.shadowOpacity = 0.4
    }
}
