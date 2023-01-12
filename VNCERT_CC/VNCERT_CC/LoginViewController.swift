//
//  LoginViewController.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 07/11/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    var userData: Users = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersFromAPI()
        // Do any additional setup after loading the view.
    }
    
    func getUsersFromAPI() {
        APIHandler.init().getUsers { userResponseData in
            self.userData = userResponseData
        }
    }
    
    func check() -> Bool {
        let email = txtEmail.text!
        let password = txtPassWord.text!
        
        if(email != "" && password != "") {
            for value in userData {
                if(value.email == email && value.password == password) {
                    return true;
                }
            }
            lblError.text = "Tài khoản không tồn tại!!"
        } else {
            lblError.text = "Chưa nhập đủ thông tin"
            
        }
        return false;
    }
    
    @IBAction func logIn(_ sender: Any) {
        let check = check()
        if check {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier:"View")
            vc .modalPresentationStyle = .overFullScreen
            present(vc,animated: true)
        }
    }
}
