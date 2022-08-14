//
//  FirstVC.swift
//  My To Do List
//
//  Created by Abdulloh Murodilloyev on 17/03/22.
//

import UIKit

protocol NewTaskDelegate {
   
    func didFinishWithTask(task: Task)
        
    
    
}

class FirstVC: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var priorityBtn: UIButton!
   
    
    var delegate: NewTaskDelegate?
    var currentTaskPriority: TaskPriority = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
   
    func setupViews() {
        self.descTextView.layer.borderWidth = 0.3
        self.descTextView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.borderWidth = 0.5
        cardView.layer.borderColor = UIColor.systemGreen.cgColor
    }
         
    

    @IBAction func priorityBtnPressed(_ sender: Any) {        
        let vc = PriorityVC(nibName: "PriorityVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if !titleField.text!.isEmpty {
            let task = Task(title: titleField.text!, description: descTextView.text!, prioriry: self.currentTaskPriority, subtasks: [])
            self.delegate?.didFinishWithTask(task: task)
            self.dismiss(animated: true, completion: nil)
        } else {
           
            let alert = UIAlertController(title: "Task title can not be  empty ", message: " Please write the task titlein order to create a new task ", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension FirstVC: PriorityDelegate {
    func didChoosePriority(priority: TaskPriority, color: UIColor, title: String) {
        self.currentTaskPriority =  priority
        self.priorityBtn.setTitle(title, for: .normal)
        self.priorityBtn.backgroundColor = color
    }
}
