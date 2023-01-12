//
//  APIHandlerBook.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 10/11/2022.
//

import Foundation
import Alamofire

class APIHandlerBook {
    func getFriends(completion: @escaping (Friends) -> ()) {
        AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/friends", method: .get).responseDecodable(of: Friends.self) { (response) in
            if let friendsResponse = response.value {
                completion(friendsResponse)
            }
        }
    }
    
    func postFriends(friend: Friend) {
        AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/friends", method: .post, parameters: friend, encoder: JSONParameterEncoder.default, headers: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
    }
    func deleteFriends(id: Int) {
            AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/friends/\(id)", method: .delete, parameters: nil, headers: nil).response { responce in
                switch responce.result {
                case .success(let data):
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                        print(json)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let erorr):
                    print(erorr.localizedDescription)
                }
            }
        }
    func putFriend(friend: Friend, id: Int) {
        AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/friends/\(id)", method: .put, parameters: friend, encoder: JSONParameterEncoder.default, headers: nil).response { responce in
            switch responce.result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                    print(json)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
    }
    }
