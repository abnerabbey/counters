//
//  FeedTableDataSource.swift
//  Counters
//
//  Created by Abner Abbey on 17/12/21.
//

import Foundation
import UIKit

class FeedTableDataSource<CellType: UITableViewCell>: NSObject, UITableViewDataSource {
    
    let cellIdentifier: String
    var items: Int
    let configureCell: (CellType, IndexPath) -> ()
    
    init(cellIdentifier: String, items: Int, configureCell: @escaping (CellType, IndexPath) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CellType else { return UITableViewCell() }
        configureCell(cell, indexPath)
        return cell
    }
    
}
