//
//  FirebaseDataViewController.swift
//  Todolist2
//
//  Created by PanaCloud on 4/10/15.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class FirebaseDataViewController {
    
    func saveData(taskName:String, taskDescription:String, uid:String) {
        var rootRef = Firebase(url: "https://to-do-list-example.firebaseio.com/Users/\(uid)")
        let ref = rootRef.childByAutoId()
        let post = ["taskTitle":"\(taskName)","taskDesc":"\(taskDescription)"]
        ref.setValue(post)
    }
    
}
