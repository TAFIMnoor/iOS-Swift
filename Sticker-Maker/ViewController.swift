//
//  ViewController.swift
//  Sticker-Maker
//
//  Created by mohammad noor uddin on 24/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var model = DataParseModel()
    var categories: [Categories]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = model.getAllCategories()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
