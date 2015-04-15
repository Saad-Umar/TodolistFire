//
//  AddTaskViewController.swift
//  Todolist2
//
//  Created by PanaCloud on 4/13/15.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDesc: UITextField!
    var uid:String!
    
    var fireInstance:FirebaseDataViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        fireInstance = FirebaseDataViewController()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveData(sender: AnyObject) {
        fireInstance.saveData(self.taskTitle.text, taskDescription: self.taskDesc.text,uid: self.uid)
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
