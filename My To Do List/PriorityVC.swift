//
//  PriorityVC.swift
//  My To Do List
//
//  Created by Abdulloh Murodilloyev on 17/03/22.
//

import UIKit


protocol PriorityDelegate {
    func didChoosePriority(priority: TaskPriority, color: UIColor, title: String)
    
}

class PriorityVC: UIViewController {
    
    var delegate: PriorityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func priorityChoosen(_ sender: UIButton) {
        var choosenPriority: TaskPriority = .none
        if sender.tag == 0 {
            choosenPriority = .none
        } else if sender.tag == 1  {
            choosenPriority = .low
        } else if sender.tag == 2 {
            choosenPriority = .medium
        } else {
            choosenPriority = .high
        }
        self.delegate?.didChoosePriority(priority: choosenPriority, color: sender.backgroundColor ?? .red, title: sender.currentTitle!)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}



