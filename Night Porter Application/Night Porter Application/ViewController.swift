//
//  ViewController.swift
//  Night Porter Table View
//
//  Created by Jaboree Muhammad on 7/30/19.
//  Copyright © 2019 Jaboree Muhammad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskTableView: UITableView!
    // Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row \(indexPath.row) in section \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let completeAction = UIContextualAction(style: .normal, title: "Completed") { (action:UIContextualAction, sourceView:UIView, actionPerformed:(Bool) -> Void) in
            
            // find the right object and set it to completed
            
            switch indexPath.section{
            case 0:
                self.dailyTasks[indexPath.row].completed = true
            case 1:
                self.weeklyTasks[indexPath.row].completed = true
            case 2:
                self.monthlyTasks[indexPath.row].completed = true
            default:
                break
            }
            
            tableView.reloadData()
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    
    // Table View Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = UIColor.clear
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dailyTasks.count
        case 1:
            return weeklyTasks.count
        case 2:
            return monthlyTasks.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    {
        let cell = UITableViewCell()
        
        // hold the current task
        var currentTask: Task!
      
        switch indexPath.section {
        case 0:
            currentTask = dailyTasks[indexPath.row]
        case 1:
            currentTask = weeklyTasks[indexPath.row]
        case 2:
            currentTask = monthlyTasks[indexPath.row]
        default:
            break
        }
        
        // Use the name property to set the value of the cell
        
        cell.textLabel?.text = currentTask.name
        if currentTask.completed {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        }
        else {
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        }
        
        // Clear out the background
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        switch section {
        case 0:
            return "Daily Tasks"
        case 1:
            return "Weekly Tasks"
        case 2:
            return "Monthly Tasks"
        default:
            return nil
        }
    }
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        let mySwitch = sender as! UISwitch
        
        if mySwitch.isOn {
            view.backgroundColor = UIColor.darkGray
        }
        else {
            view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func resetList(_ sender: Any) {
    
        let confirm = UIAlertController(title: "Are you sure?", message: "Really reset the list?" , preferredStyle: .alert )
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) {
            action in
            
            for i in 0..<self.dailyTasks.count {
                self.dailyTasks[i].completed = false
            }
            for i in 0..<self.weeklyTasks.count {
                self.weeklyTasks[i].completed = false
            }
            for i in 0..<self.monthlyTasks.count {
                self.monthlyTasks[i].completed = false
            }
            
            self.taskTableView.reloadData()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) {
            action in
            
            print("That was a close one!")
        }
        
        // Add action to alert controller
        
        confirm.addAction(yesAction)
        confirm.addAction(noAction)
        
        // Show it
        present(confirm , animated: true, completion: nil )
    }
    
    // Create [String] arrays of tasks ---> turned into tasks arrays
    var dailyTasks = [
        Task(name: "Check all windows", type: .daily, completed: false, lastcompleted: nil),
        Task(name: "Check all doors", type: .daily, completed: false, lastcompleted: nil),
        Task(name: "Is the boiler fueled?", type: .daily, completed: false, lastcompleted: nil),
        Task(name: "Check the mailbox", type: .daily, completed: false, lastcompleted: nil),
        Task(name: "Empty the trash can", type: .daily, completed: false, lastcompleted: nil),
        Task(name: "I'm freezing, check the water pipes", type: .daily, completed: false, lastcompleted: nil),
        Task(name: "Document 'strange and unusal occurrences'", type: .daily, completed: false, lastcompleted: nil)
    ]
    
    var weeklyTasks = [
        Task(name: "Check inside all cabinets", type: .weekly, completed: false, lastcompleted: nil),
        Task(name: "Flush all lavatories in cabins", type: .weekly, completed: false, lastcompleted: nil),
        Task(name: "Walk perimeter of the property", type: .weekly, completed: false, lastcompleted: nil)
    ]
    
    var monthlyTasks = [
        Task(name: "Test security alarm", type: .monthly, completed: false, lastcompleted: nil),
        Task(name: "Test security alarm", type: .monthly, completed: false, lastcompleted: nil),
        Task(name: "Test security alarm", type: .monthly, completed: false, lastcompleted: nil)
    ]
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
