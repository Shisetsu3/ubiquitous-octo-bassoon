//
//  DataRequestController.swift
//  UI_Project
//
//  Created by  Shisetsu on 02.02.2021.
//

import UIKit
import Alamofire

class DataRequestController: UIViewController {
    @IBOutlet weak var tokenText: UITextField!
    @IBOutlet weak var userIDText: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenText.text = VKSession.info.token
        userIDText.text = String(VKSession.info.userId)
    }
    
//    func createRequestUrl(method: String, parameter: String, parameterData: String, get: String, who: String, dataStructure: String) -> [Any] {
//        let url = URL(string: "https://api.vk.com/method/\(method).\(get)?\(who)_id=\(VKSession.info.userId)&\(parameter)=\(parameterData)&access_token=\(VKSession.info.token)&v=5.126")
//        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
//
//            var userArray: [Users]
//            var groupArray: [Groups]
//
//            if dataStructure == "User" {
//                guard let data = data,
//                      let jsonData = try? JSONDecoder().decode(User.self, from: data) else {
//                    return
//                }
//                userArray = jsonData.response.items
//                friendsData = userArray
//                print("Data from func")
//                //print(userArray)
//                return
//
//            } else if dataStructure == "Group" {
//                guard let data = data,
//                      let jsonData = try? JSONDecoder().decode(Group.self, from: data) else {
//                    return
//                }
//                groupArray = jsonData.response.items
//                groupsData = groupArray
//                //print(self.groupData)
//                return
//            } else {
//                return
//            }
//        }.resume()
//        return []
//    }
    
    //    @IBAction func searchGroup(_ sender: Any) {
    //        createRequestUrl(method: "groups", parameter: "q", parameterData: "breaker", get: "search", who: "user")
    //    }
    
    //    @IBAction func getPhoto(_ sender: Any) {
    //        createRequestUrl(method: "photos", parameter: "extended", parameterData: "1", get: "getAll", who: "owner")
    //    }
}
