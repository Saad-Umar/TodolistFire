//
//  SignUpViewController.swift
//  Todolist2
//
//  Created by PanaCloud on 4/14/15.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

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
    

    @IBAction func SignUpBtnPressed(sender: AnyObject) {
        let ref = Firebase(url: "https://to-do-list-example.firebaseio.com/")
        ref.createUser(emailTxtFld.text, password: passwordTxtFld.text, { error, result in
            
            if error != nil{
                println("Failed")
            } else {
                println("Success")
                ref.authUser(self.emailTxtFld.text, password: self.passwordTxtFld.text, withCompletionBlock: { error, authData in
                    if error != nil {
                        println("Nay!")
                    } else {
                        println("Successful login")
                        self.uid = authData.uid
                        self.performSegueWithIdentifier("SignedUp", sender: self)
                    }
                })
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let newVc = segue.destinationViewController as ListViewController
        newVc.uid = self.uid
        
    }
}
