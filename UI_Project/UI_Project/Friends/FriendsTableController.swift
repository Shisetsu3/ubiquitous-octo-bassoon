//
//  FriendsTableController.swift
//  UI_Project
//
//  Created by Shisetsu on 11.12.2020.
//

import UIKit
import RealmSwift

class FriendsTableController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendsData: Results<Users>?
    var sections: [String: [Users]] = [:]
    var keys: [String] = []
    var filteredData = [Users]()
    var searchBarStatus = false
    var imageName1 = UIImage()
    var imageName2 = UIImage()
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 60
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        
        getFriends()
        pairTableAndRealm()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.friendsData!.forEach { friend in
                let firstLetter = String(friend.firstName.first!)
                if self.sections[firstLetter] != nil {
                    self.sections[firstLetter]!.append(friend)
                } else {
                    self.sections[firstLetter] = [friend]
                }
            }
            self.keys = Array(self.sections.keys).sorted(by: <)
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = friendsData!.filter ({ (friend: Users) -> Bool in
            return friend.firstName.lowercased().contains(searchText.lowercased())
        })
        searchBar.showsCancelButton = true
        searchBarStatus = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        searchBarStatus = false
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let returnedView = UIView(frame: CGRect(x: 30, y: 20, width: 42, height: 42))
        returnedView.backgroundColor = UIColor.lightGray
        returnedView.alpha = 0.5
        
        let label = UILabel(frame: CGRect(x: 4, y: 4, width: 160, height: 20))
        label.textColor = .black
        if searchBarStatus {
            label.text = "Результат поиска"
        } else {
            label.text = keys[section]
        }
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarStatus {
            return filteredData.count
        }
        let key = keys[section]
        let count = sections[key]!.count
        return count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchBarStatus {
            return 1
        }
        return sections.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searchBarStatus {
            return ["#"]
        }
        return keys
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(
            withDuration: 0.25,
            animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let viewAvatar = tableView.cellForRow(at: indexPath) as? TableViewCell else {return}
        
        let spring = CASpringAnimation(keyPath: "transform.scale")
        spring.duration = 0.5
        spring.damping = 0.1
        spring.initialVelocity = 0.1
        spring.fromValue = 1
        spring.toValue = 0.9
        
        let animation = CAAnimationGroup()
        animation.duration = 1
        animation.animations = [spring]
        
        viewAvatar.headerView.layer.add(animation, forKey: "spring")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFriends", for: indexPath) as! TableViewCell
        
        let key = keys[indexPath.section]
        
        if searchBarStatus {
            let searchedFriends = filteredData[indexPath.row]
            cell.friendLabel.text = searchedFriends.firstName + " " + searchedFriends.lastName
            let imageUrlString1 = searchedFriends.photo
            let imageUrl1 = URL(string: imageUrlString1)!
            let imageData1 = try! Data(contentsOf: imageUrl1)
            imageName1 = UIImage(data: imageData1)!
            cell.friendPhoto.image = imageName1
        } else {
            let friendsClass = sections[key]![indexPath.row]
            cell.friendLabel.text = friendsClass.firstName + " " + friendsClass.lastName
            let imageUrlString2 = friendsClass.photo
            let imageUrl2 = URL(string: imageUrlString2)!
            let imageData2 = try! Data(contentsOf: imageUrl2)
            imageName2 = UIImage(data: imageData2)!
            cell.friendPhoto.image = imageName2 //UIImage(named: friendsClass.photo50)
        }
        
        cell.friendPhoto.clipsToBounds = true
        cell.friendPhoto.layer.cornerRadius = cell.friendPhoto.frame.height / 2
        cell.headerView.addSubview(cell.friendPhoto)
        
        cell.addSubview(cell.headerView)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProfileController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let key = keys[indexPath.section]
            if searchBarStatus {
                let searchedFriends = filteredData[indexPath.row]
                vc.userPhoto = imageName1
                vc.userName = searchedFriends.firstName
                vc.userSurname = searchedFriends.lastName
                //vc.userCity = searchedFriends.city?.title
                vc.userBirth = searchedFriends.bdate
                if searchedFriends.online == 1 {
                    vc.userStatus = "Online"
                } else if searchedFriends.online == 0 {
                    vc.userStatus = "Offline"
                }
                vc.userID = searchedFriends.id
            } else {
                let friendsClass = sections[key]![indexPath.row]
                let imageUrlString2 = friendsClass.photo
                let imageUrl2 = URL(string: imageUrlString2)!
                let imageData2 = try! Data(contentsOf: imageUrl2)
                imageName2 = UIImage(data: imageData2)!
                vc.userPhoto = imageName2
                vc.userName = friendsClass.firstName
                vc.userSurname = friendsClass.lastName
                //vc.userCity = friendsClass.city?.title
                vc.userBirth = friendsClass.bdate
                if friendsClass.online == 1 {
                    vc.userStatus = "Online"
                } else if friendsClass.online == 0 {
                    vc.userStatus = "Offline"
                }
                vc.userID = friendsClass.id
            }
        }
    }
    
    func saveFriendsData(_ users: [Users]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(users, update: .modified)
            try realm.commitWrite()
            print("URL FOR BASE")
            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
    func getFriends() {
        let url = URL(string: "https://api.vk.com/method/friends.get?user_id=\(VKSession.info.userId)&fields=nickname,sex,bdate,city,photo_200_orig,online&access_token=\(VKSession.info.token)&v=5.126")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode(User.self, from: data)
                let usersToDB = jsonData.response.items
                self.saveFriendsData(usersToDB)
            } catch {
                print("Error is : \n\(error)")
            }
        }.resume()
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        
        friendsData = realm.objects(Users.self)
        token = friendsData!.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update:
                tableView.beginUpdates()
                tableView.reloadData()
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
}

