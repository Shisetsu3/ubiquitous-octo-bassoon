//
//  DataRequestController.swift
//  UI_Project
//
//  Created by  Shisetsu on 02.02.2021.
//

import UIKit

class DataRequestController: UIViewController {
    @IBOutlet weak var tokenText: UITextField!
    @IBOutlet weak var userIDText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenText.text = VKSession.info.token
        userIDText.text = String(VKSession.info.userId)
    }
    
    func createRequestUrl(method: String, parameter: String, parameterData: String, get: String, who: String) {
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        let url = URL(string: "https://api.vk.com/method/\(method).\(get)?\(who)_id=\(VKSession.info.userId)&\(parameter)=\(parameterData)&access_token=\(VKSession.info.token)&v=5.126")
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json!)
        }
        task.resume()
    }
    
    @IBAction func getFriends(_ sender: Any) {
        createRequestUrl(method: "friends", parameter: "fields", parameterData: "nickname", get: "get", who: "user")
    }
    
    @IBAction func getPhoto(_ sender: Any) {
        createRequestUrl(method: "photos", parameter: "extended", parameterData: "1", get: "getAll", who: "owner")
    }
    
    @IBAction func getGroups(_ sender: Any) {
        createRequestUrl(method: "groups", parameter: "extended", parameterData: "1", get: "get", who: "user")
    }
    
    @IBAction func searchGroup(_ sender: Any) {
        createRequestUrl(method: "groups", parameter: "q", parameterData: "breaker", get: "search", who: "user")
    }
}
