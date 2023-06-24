//
//  ColorsDetailVC.swift
//  Colors App
//
//  Created by mohammad noor uddin on 7/6/23.
//

import UIKit

class ColorsDetailVC: UIViewController {
    
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color ?? .systemMint
    }
    
}
