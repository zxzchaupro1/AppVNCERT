//
//  ViewController.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 07/11/2022.
//

import UIKit
import Kingfisher
import Alamofire

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tblUsers: UITableView!
    
    var usersData : Users = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblUsers.delegate = self
        tblUsers.dataSource = self
        tblUsers.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        getUsersFromAPI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblUsers.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        
        let currentUser = usersData [indexPath.row]
        cell.lblUserName.text = currentUser.name
        cell.lblEmail.text = currentUser.email
        cell.lblPassword.text = currentUser.password
        cell.btnDeletePerson.tag = Int(currentUser.id)!
        cell.btnDeletePerson.addTarget(self, action: #selector(deletePerson(_:)), for: .touchUpInside)
        cell.indexPath = indexPath
        return cell
    }
    
    
    //Buoc 2
    @objc func deletePerson(_ sender: UIButton) {
        let id:Int = sender.tag
        APIHandler.init().deleteUsers(id: id)
        getUsersFromAPI()
        self.tblUsers.reloadData()
    }
    
    func getUsersFromAPI() {
        APIHandler.init().getUsers { usersResponseData in
            self.usersData = usersResponseData
            self.tblUsers.reloadData()
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"Home")
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    @IBAction func Go(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"Book")
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
}
    


    

