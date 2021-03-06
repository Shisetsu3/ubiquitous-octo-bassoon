//
//  TableViewController_Groups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit
import RealmSwift
import FirebaseDatabase
import FirebaseAuth
import Firebase
import FirebaseFirestore



class TableViewControllerGroups: UITableViewController {
    
    let fireDB = Firestore.firestore()
    var userGroups = [Groups]()
    var userRealmGroups: Results<Groups>?
    let realm = try! Realm()
    var token: NotificationToken?
    let currentUser = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        print(currentUser!)
        super.viewDidLoad()
        self.tableView.rowHeight = 45
        
        getGroups()
        loadGroupsData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userRealmGroups!.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroups", for: indexPath) as! TableViewCellGroups
        let groups = userRealmGroups![indexPath.row]
        cell.userGroupsLabel.text = groups.name
        let imageUrlString2 = groups.photo
        let imageUrl2 = URL(string: imageUrlString2)!
        let imageData2 = try! Data(contentsOf: imageUrl2)
        let imageName2 = UIImage(data: imageData2)!
        cell.userGroupsPhoto.image = imageName2
        cell.userGroupsPhoto.layer.cornerRadius = cell.userGroupsPhoto.frame.width / 2
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = userRealmGroups?[indexPath.row] {
                try! realm.write {
                    realm.delete(item)
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func showSerachScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchScreen") as! TableViewControllerRecomendGroups
        self.navigationController!.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let RecomendedGroups = segue.source as? TableViewControllerRecomendGroups else { return }
            

            if let indexPath = RecomendedGroups.tableView.indexPathForSelectedRow {
                let searchedGroups = RecomendedGroups.sendData[indexPath.row]
                if !userRealmGroups!.contains(searchedGroups) {
                    do {
                        fireDB.collection("Database").document(currentUser!).setData([                            "groupName": FieldValue.arrayUnion([searchedGroups.name]),
                            "groupPhoto": FieldValue.arrayUnion([searchedGroups.photo])
                        ],merge: true) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!")
                            }
                        }
                        let realm = try Realm()
                        realm.beginWrite()
                        realm.add(searchedGroups, update: .modified)
                        try realm.commitWrite()
                        print("URL FOR BASE")
                        print(realm.configuration.fileURL!)
                    } catch {
                        print(error)
                    }
                    tableView.reloadData()
                }
            }
        }
    }
    
    func saveGroupsData(_ groups: [Groups]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(groups, update: .modified)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadGroupsData() {
        do {
            userRealmGroups = realm.objects(Groups.self)
            token = userRealmGroups!.observe { [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update:
                    tableView.beginUpdates()
                    tableView.reloadData()
                    print("DATA IS UPDATED!")
                    tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
        }
    }
    
    func getGroups() {
        let url = URL(string: "https://api.vk.com/method/groups.get?user_id=\(VKSession.info.userId)&extended=1&access_token=\(VKSession.info.token)&v=5.130")
        print(url!)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode(Group.self, from: data)
                let groupsToDB = jsonData.response.items
                self.saveGroupsData(groupsToDB)
            } catch {
                print("Error is : \n\(error)")
            }
        }.resume()
    }
}
