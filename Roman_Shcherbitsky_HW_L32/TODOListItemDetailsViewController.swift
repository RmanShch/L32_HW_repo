//
//  TODOListItemDetailsViewController.swift
//  Roman_Shcherbitsky_HW_L32
//
//  Created by Анна Шербицкая on 9.02.22.
//

import Foundation
import UIKit

protocol TODOListItemDetailsDelegate {
    func todoListItemDetailsViewController(_ controller: TODOListItemDetailsViewController, didFinishEditingOfItem item: TODOListItem)
}

class TODOListItemDetailsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView?
    
    var delegate: TODOListItemDetailsDelegate?
    var currentItem: TODOListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView?.text = currentItem?.body
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard var currentItem = currentItem else { return }
        let body = textView?.text ?? ""
        currentItem.body = body
        currentItem.title = body.split(separator: "\n").first?.base ?? "Item"
        currentItem.lastUpdatedDate = .now
        
        delegate?.todoListItemDetailsViewController(self,
                                                    didFinishEditingOfItem: currentItem)
    }
}
