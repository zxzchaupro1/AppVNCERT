//
//  RegisterViewController.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 07/11/2022.
//

import UIKit
import Kingfisher
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    @IBOutlet weak var txtRpPassWord: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!
    
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
    
    func check() -> Bool{
        let name = txtFullName.text!
        let email = txtEmail.text!
        let password = txtPassWord.text!
        let rpPassword = txtRpPassWord.text!
        
        if(name != "" && email != "" && password != "" && rpPassword != "") {
            for value in userData {
                if(value.email == email) {
                    lblError.text = "Email đã được sử dụng";
                    return false;
                }
            }
            if(password == rpPassword) {
                addData(name: name, email: email, password: password)
                return true;
            } else {
                lblError.text = "Mật Khẩu nhập lại chưa khớp"
            }
            
        } else {
            lblError.text = "Chưa nhập đủ thông tin"
            
        }
        return false;
    }
    
    func addData(name:String, email:String, password: String) {
        let user = User(createdAt:"", name: "\(name)", avatar:"", email: "\(email)", password: "\(password)", id: "1")
        APIHandler.init().postUsers(user: user)
    }
    
    @IBAction func signUp(_ sender: Any) {

        let check = check()
        if(check) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier:"Login")
            vc .modalPresentationStyle = .overFullScreen
            present(vc,animated: true)
        }
    }
}
