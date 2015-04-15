//
//  AuthViewController.swift
//  Todolist2
//
//  Created by PanaCloud on 4/14/15.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    var uid:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnPressed(sender: AnyObject) {
        let ref = Firebase(url: "https://to-do-list-example.firebaseio.com")
        ref.authUser(emailTxtFld.text, password: passwordTxtFld.text, withCompletionBlock: { error, authData in
            
            if error != nil{
                println("Failed11")
            } else {

                println(authData.uid)
                println("Logged In")
                self.uid = authData.uid
                self.performSegueWithIdentifier("LoggedIn", sender: self)
            }
        
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LoggedIn" {
        let newVc = segue.destinationViewController as ListViewController
        newVc.uid = self.uid
        }
    }

}
