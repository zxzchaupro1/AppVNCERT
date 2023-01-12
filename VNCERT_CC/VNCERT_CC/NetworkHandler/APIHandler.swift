//
//  APIHandler.swift
//  VNCERT_CC
//
//  Created by ChâuNT on 07/11/2022.
//

import Foundation
import Alamofire

class APIHandler {
    func getUsers(completion: @escaping (Users) -> ()) {
        AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/User", method: .get).responseDecodable(of: Users.self) { (response) in
            if let usersResponse = response.value {
                completion(usersResponse)
            }
        }
    }
    //Thêm thông tin qua phương thức post
    func postUsers(user: User) {
        AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/User", method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: nil).response { responce in
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
    //Xóa thông tin qua phương thức delete
    func deleteUsers(id: Int) {
            AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/User\(id)", method: .delete, parameters: nil, headers: nil).response { responce in
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
    //Sửa thông tin qua phương thức put
    func putUsers(user: User, id: Int) {
        AF.request("https://632c7f1a1aabd837399d7808.mockapi.io/User\(id)", method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: nil).response { responce in
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
