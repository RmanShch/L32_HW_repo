//
//  TODOListViewController.swift
//  Roman_Shcherbitsky_HW_L32
//
//  Created by Анна Шербицкая on 9.02.22.
//

import UIKit

fileprivate struct ViewConfig {
    static let kCellHeight: CGFloat = 55
}

protocol PersistenceManager {
    func save(item: TODOListItem)
    func remove(item: TODOListItem)
    func loadAllItems() -> [TODOListItem]?
}

class TODOListViewController: UIViewController {
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var persistenceManager: PersistenceManager?
    let dataSource = TODOListDataSource()
    var selectedItem: TODOListItem? //Empty for new item
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performInitialConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadStoredItems()
    }
    
    func performInitialConfiguration() {
        persistenceManager = RealmManager()
        tableView.delegate = self
        tableView.dataSource = dataSource
        dataSource.delegate = self
    }
    
    func loadStoredItems() {
        let items = persistenceManager?.loadAllItems()
        dataSource.items = items
        tableView.reloadData()
    }
    
    func moveToListItemDetailsViewController() {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "TODOListItemDetailsViewController") as! TODOListItemDetailsViewController
        vc.currentItem = selectedItem
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onAddButtonDidTap(_ sender: UIBarButtonItem) {
        selectedItem = TODOListItem(title: "", body: "", lastUpdatedDate: .now, createdDate: .now)
        moveToListItemDetailsViewController()
    }
    
}

extension TODOListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.items?[indexPath.row] else { return }
        selectedItem = item
        moveToListItemDetailsViewController()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ViewConfig.kCellHeight
    }
}

extension TODOListViewController: TODOListItemDetailsDelegate {
    func todoListItemDetailsViewController(_ controller: TODOListItemDetailsViewController, didFinishEditingOfItem item: TODOListItem) {
        persistenceManager?.save(item: item)
        loadStoredItems()
    }
}

extension TODOListViewController: TODOListDataSourceDelegate {
    func todoItemIsDeleted(_ item: TODOListItem) {
        persistenceManager?.remove(item: item)
        //loadStoredItems()
    }
}
