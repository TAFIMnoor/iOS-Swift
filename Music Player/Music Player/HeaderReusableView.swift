//
//  HeaderReusableView.swift
//  Music Player
//
//  Created by mohammad noor uddin on 20/6/23.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    var  titleText: String!
    var titleLabel: UILabel {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 20.0, y: CGRectGetMidY(self.bounds)-15, width: 414, height: 30)
        titleLabel.text = titleText
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20.0)
        return titleLabel
    }
    
    public func configure(){
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
}
