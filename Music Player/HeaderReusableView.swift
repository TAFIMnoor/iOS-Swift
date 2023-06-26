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
        
        titleLabel.textColor = UIColor(red: 199.0/255.0, green: 214.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        titleLabel.font = .boldSystemFont(ofSize: 23.0)
        return titleLabel
    }
    
    lazy var lineView: UIView = {
        let lineView = UIView(frame: CGRect(x: 15, y: bounds.height - 4, width: bounds.width, height: 1))
        lineView.backgroundColor = UIColor(red: 49.0/255.0, green: 52.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        return lineView
    }()

    
    public func configure(){
        addSubview(titleLabel)
        addSubview(lineView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
}
