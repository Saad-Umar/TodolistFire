//
//  ListViewController.swift
//  Todolist2
//
//  Created by PanaCloud on 4/10/15.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var listView: UITableView!
    var toDoItemList:[Todoitem]!
    var uid:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDoItemList = []
        readData()
        println("In list view \(uid)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Reading data from Firebase
    
    func readData() {
        var rootRef:Firebase!
        rootRef = Firebase(url: "https://to-do-list-example.firebaseio.com/Users/\(uid)")
        rootRef.observeEventType(.Value, withBlock: {
            snapshot in
            self.toDoItemList = []
            println("\(snapshot.value)")
            if !(snapshot.value is NSNull) {
            for childSnap in snapshot.children.allObjects as [FDataSnapshot] {
                
                let taskID = childSnap.key
                let taskTitle = childSnap.value.objectForKey("taskTitle") as String
                let taskDesc = childSnap.value.objectForKey("taskDesc") as String
                
                self.toDoItemList.append(Todoitem(taskID: taskID, taskName: taskTitle, taskDesc: taskDesc))
            }
                
            self.listView.reloadData()
                
            }
            else{
                
                let alert = UIAlertController(title: "Sorry!", message: "You haven't saved any tasks yet!", preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newVc = segue.destinationViewController as AddTaskViewController
        newVc.uid = self.uid
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = toDoItemList[indexPath.row].taskName
        cell.detailTextLabel?.text = toDoItemList[indexPath.row].taskDesc
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemList.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var ref:Firebase!
            ref = Firebase(url: "https://to-do-list-example.firebaseio.com/tasks")
            var refToDelete = ref.childByAppendingPath(toDoItemList[indexPath.row].taskID)
            refToDelete.removeValue()
        }
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
         return true
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
struct Todoitem
{
    let taskID:String!
    let taskName:String!
    let taskDesc:String!
}