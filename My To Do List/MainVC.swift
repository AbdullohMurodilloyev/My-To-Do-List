//
//  MainVC.swift
//  My To Do List
//
//  Created by Abdulloh Murodilloyev on 17/03/22.
//

import UIKit

class MainVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var newTasks: [Task] = []
    var finishedTasks: [Task] = []
    var archivedTasks: [Task] = []
    var sectionTitles: [String] = ["New Tasks", "Finished Tasks", "Archived Tasks"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MainTVC", bundle: nil), forCellReuseIdentifier: "MainTVC")
//        self.tableView.contentInset = .init(top: 20, left: 0, bottom: 50, right: 0)
        
    }
    
    @IBAction func addBtnPressed(_ sender: UIView) {
        let vc = FirstVC(nibName: "FirstVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
}

// MARK: - Table View Methods -

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            // new
            return newTasks.count
        } else if section == 1 {
            // finished
            return finishedTasks.count
        } else {
            return archivedTasks.count
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTVC", for: indexPath) as! MainTVC
        
        
        
        if indexPath.section == 0 {
            // new tasks
            cell.updateCell(with: newTasks[indexPath.row])
        
        } else if indexPath.section == 1 {
            // finished Tasks
            cell.updateCell(with: finishedTasks[indexPath.row])
       
        } else {
            // archived Tasks
            cell.updateCell(with: archivedTasks[indexPath.row])
        }
               
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       var choosenTask: Task!
        
        
        if indexPath.section == 0 {
            // new tasks
            choosenTask = newTasks[indexPath.row]
        
        } else if indexPath.section == 1 {
            // finished
            choosenTask = finishedTasks[indexPath.row]
       
        } else {
            // archived
            choosenTask = archivedTasks[indexPath.row]
        }
        
        
        let alert = UIAlertController(title: "Choose what to do ", message: nil, preferredStyle: .actionSheet)
      
        let finish =  UIAlertAction(title: "Finish 🥳", style: .default ) { (_) in
            // Finish action
            choosenTask.state = .finishid
            self.finishedTasks.append(choosenTask)
            self.newTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        }
        
        let archive = UIAlertAction(title: "Archive", style: .default ) { (_) in
            choosenTask.state = .archived
            self.archivedTasks.append(choosenTask)
            if indexPath.section == 0 {
                self.newTasks.remove(at: indexPath.row)
            } else {
                self.finishedTasks.remove(at: indexPath.row)
            }
            
            self.tableView.reloadData()
        }
      
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let unarchive = UIAlertAction(title: "Unarchive", style: .default) { (_) in
            choosenTask.state = .new
            self.newTasks.append(choosenTask)
            self.archivedTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        }
        
        let unfinish = UIAlertAction(title: "Unfinish", style: .default) { (_) in
            choosenTask.state = .new
            self.newTasks.append(choosenTask)
            self.finishedTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        if indexPath.section == 0 {
            // new tasks
            alert.addAction(finish)
            alert.addAction(archive)
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.newTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
                
            }
            alert.addAction(delete)
        
        } else if indexPath.section == 1 {
            // finished
            alert.addAction(unfinish)
            alert.addAction(archive)
          
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.finishedTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
                
            }
            alert.addAction(delete)
        } else {
            // archived
            alert.addAction(unarchive)
           
            let delete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
                self.archivedTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
                
            }
            alert.addAction(delete)
        }
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: .zero)
        v.backgroundColor = .clear
        
        let lbl = UILabel(frame: CGRect(x: self.view.frame.width/2-150/2, y: 0, width: 150, height: 30))
        v.addSubview(lbl)
        lbl.text = sectionTitles[section]
        if #available(iOS 13.0, *) {
            lbl.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
        }
        lbl.layer.cornerRadius = 15
        lbl.clipsToBounds = true
        lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        lbl.textColor = .systemGreen
        lbl.textAlignment = .center
        
        
        if tableView.numberOfRows(inSection: section) == 0 {
            lbl.alpha = 0
           
        } else {
            lbl.alpha = 1
        }
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){(_,_,_) in
            if indexPath.section == 0 {
                self.newTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                
                self.finishedTasks.remove(at: indexPath.row)
            } else {
                self.archivedTasks.remove(at: indexPath.row)
            }
            
            self.tableView.reloadData()
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
}

//MARK: - NewTaskDelegate -
extension MainVC: NewTaskDelegate {
    func didFinishWithTask(task: Task) {
        self.newTasks.append(task)
        self.tableView.reloadData()
    }
    
}
