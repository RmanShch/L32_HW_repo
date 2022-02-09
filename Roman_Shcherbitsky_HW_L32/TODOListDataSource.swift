//
//  TODOListDataSource.swift
//  Roman_Shcherbitsky_HW_L32
//
//  Created by Анна Шербицкая on 9.02.22.
//

import Foundation
import UIKit

protocol TODOListDataSourceDelegate {
    func todoItemIsDeleted(_ item: TODOListItem)
}

class TODOListDataSource: NSObject, UITableViewDataSource {
    var items: [TODOListItem]?
    
    var delegate: TODOListDataSourceDelegate?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = items else { return UITableViewCell() }

        let id = "default"
        let cell: UITableViewCell
        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: id) {
            cell = reusedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        guard let item = items?[indexPath.row] else { return }
        self.items?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
        delegate?.todoItemIsDeleted(item)
//        guard let item = items?[indexPath.row] else { return }
//        delegate?.todoItemIsDeleted(item)
    }
    
}
