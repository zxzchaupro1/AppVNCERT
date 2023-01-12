//
//  BookViewController.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 10/11/2022.
//

import UIKit
import Kingfisher
import Alamofire

class BookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var txtAvatar: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var btnAddNewPerson: UIButton!
    @IBOutlet weak var tblFriends: UITableView!
    
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var btnReload: UIButton!
    var friendsData: Friends = []
    //Buoc 1
    var likeDictionary: [Int:Bool] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFriends.delegate = self
        tblFriends.dataSource = self
        tblFriends.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "BookTableViewCell")
        getSaveData()
        if friendsData.isEmpty {
            getFriendsFromAPI()
            print("Gọi API")
            saveData()
            
        } else {
            
            print("dữ liệu đã tồn tại")
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFriends.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        
        let currentFriend = friendsData[indexPath.row]
        let url = URL(string: currentFriend.avatar)
        cell.imgFriendAvatar.kf.setImage(with: url)
        cell.lblFriendName.text = currentFriend.name
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeAction(_:)), for: .touchUpInside)
        cell.btnDeletePerson.tag = Int(currentFriend.id)!
        cell.btnDeletePerson.addTarget(self, action: #selector(deletePerson(_:)), for: .touchUpInside)
        
        cell.btnChangeInfo.tag = Int(currentFriend.id)!
        cell.btnChangeInfo.addTarget(self, action: #selector(putInfo(_:)), for: .touchUpInside)
        
        //Buoc 3
        if let isButtonLiked = likeDictionary[indexPath.row] {
            if isButtonLiked {
                cell.likeButton.setImage(UIImage(named: "liked"), for: .normal)
            }
        }
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFriend = friendsData[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"ContentViewControllerID") as! ContentViewController
        vc.frienData = currentFriend
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    
    //Buoc 2
    @objc func likeAction(_ sender: UIButton) {
        if let isButtonLiked = likeDictionary[sender.tag] {
            likeDictionary[sender.tag] = !isButtonLiked
        } else {
            likeDictionary[sender.tag] = true
        }
        tblFriends.reloadData()
    }
    

    @objc func deletePerson(_ sender: UIButton) {
        let id:Int = sender.tag
        APIHandlerBook.init().deleteFriends(id: id)
        getFriendsFromAPI()
        self.tblFriends.reloadData()
    }
    
    

    @objc func putInfo(_ sender: UIButton) {
        let id:Int = sender.tag
        putData(id: id, creatAt: "2022-09-28T00:55:28.152Z")
        txtAvatar.text = ""
        txtUserName.text = ""
        
    }
    @IBAction func reloadData(_ sender: UIButton) {
        getFriendsFromAPI()
        self.tblFriends.reloadData()
    }
    

    
    func getFriendsFromAPI() {
        APIHandlerBook.init().getFriends { friendsResponseData in
            self.friendsData = friendsResponseData
            self.tblFriends.reloadData()
        }
    }
    
    func getSaveData() {
        if !self.friendsData.isEmpty
        {
           let data = UserDefaults.standard.data(forKey: "saveData")
            let saveData = try? JSONDecoder().decode(Friends.self, from: data!)
            self.friendsData = saveData!
           print("đã lưu")
            viewDidLoad()
       }
        else {
            self.friendsData = []
        }
        
    }
    
    func saveData() {
        UserDefaults.standard.set(try? JSONEncoder().encode(self.friendsData), forKey: "saveData")
    }
    func putData(id: Int, creatAt: String) {
        let changeFriend = Friend(
            createdAt: "\(creatAt)",
            name: "\(txtUserName.text!)",
            avatar: "\(txtAvatar.text!)",
            id: "\(id)", content:"\(txtContent.text)"
            )
        APIHandlerBook.init().putFriend(friend: changeFriend, id: id)
        getFriendsFromAPI()
        self.tblFriends.reloadData()
    }
    
    func addData(name:String, avatar:String) {
        let friend = Friend(createdAt:"50", name:"\(name)", avatar: "\(avatar)", id: "50", content:"\(txtContent.text)" )
        APIHandlerBook.init().postFriends(friend: friend)
        getFriendsFromAPI()
        self.tblFriends.reloadData()
    }
    
    @IBAction func btnAddNew(_ sender: UIButton) {
        let name = txtUserName.text!
        let avatar = txtAvatar.text!
        addData(name: name, avatar: avatar
        )
        txtAvatar.text=""
        txtUserName.text=""
    }
    @IBAction func logOut(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"Home")
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"View")
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
}
