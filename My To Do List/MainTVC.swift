//
//  MainTVC.swift
//  My To Do List
//
//  Created by Abdulloh Murodilloyev on 17/03/22.
//

import UIKit

class MainTVC: UITableViewCell {
    
    
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDesk: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func updateCell(with task: Task ) {
        self.taskTitle.text = task.title
        self.taskDesk.text = task.description
        
//        if task.state == .new {
//            backView.backgroundColor = .systemGray6
//        } else if task.state == .finishid {
//            backView.backgroundColor = .systemGray5
//        } else {
//
//            backView.backgroundColor = .systemGray4
//        }
        
        switch task.prioriry {
        case.none:
            self.backView.backgroundColor = .systemGray
        case .high:
            self.backView.backgroundColor = .systemRed
        case .medium:
            self.backView.backgroundColor = .systemYellow
        case .low:
            self.backView.backgroundColor = .systemGreen
        
        }
    }
}
