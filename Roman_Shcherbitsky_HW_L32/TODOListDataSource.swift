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
    
    func makingDateStringWithDateFormat(with string: String, with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let items = items else { return UITableViewCell() }

        let id = "itemCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) as? TODOItemCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("TODOItemCell", owner: nil, options: nil)?[0] as? TODOItemCell
        }
        
        let item = items[indexPath.row]
        
        let editDayString = makingDateStringWithDateFormat(with: "dd MMM yyyy", with: item.lastUpdatedDate)
        let editTimeString = makingDateStringWithDateFormat(with: "HH:mm", with: item.lastUpdatedDate)
        
        cell?.editDayLabel.text = editDayString
        cell?.editTimeLabel.text = editTimeString
        cell?.titleLabel?.text = item.title
        
        return cell!
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
