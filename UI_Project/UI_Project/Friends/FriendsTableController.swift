//
//  FriendsTableController.swift
//  UI_Project
//
//  Created by Shisetsu on 11.12.2020.
//

import UIKit

@IBDesignable class FriendsTableController: UITableViewController, UISearchBarDelegate {
    
    @IBInspectable var opacity:Float = 0.5
    @IBInspectable var radius:CGFloat = 0
    @IBInspectable var color:UIColor = .gray
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendsData = [
        UserInfo(fio: "Петр Иванов", userID: "GHAVR6R", name: "Петр", onlineStatus: "Online", userAvatar: "Petya.png", surname: "Иванов", age: 25, birthDate: "13.01.1995", city: "Москва", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(fio: "Василий Сидоров", userID: "NNBAGBB", name: "Василий",  onlineStatus: "Offline", userAvatar: "Vasya.png", surname: "Сидоров", age: 32, birthDate: "19.02.1988", city: "Воронеж", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(fio: "Федор Горюнов", userID: "BBSJLOP", name: "Федор", onlineStatus: "Offline", userAvatar: "Fedor.png", surname: "Горюнов", age:40, birthDate: "10.07.1980", city: "Санкт-Петербург", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(fio: "Владимир Сергеев",userID: "VW5PFLM", name: "Владимир", onlineStatus: "Online", userAvatar: "Vova.png", surname: "Сегреев", age:18, birthDate: "13.03.2002", city: "Нижний Новгород", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(fio: "Виктор Бунин", userID: "MNDBJ76", name: "Виктор", onlineStatus: "Online", userAvatar: "Viktor.png", surname: "Бунин", age:28, birthDate: "18.05.1992", city: "Псков", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(fio: "Виктория Авдошина", userID: "KJKJKD1", name: "Виктория",  onlineStatus: "Offline", userAvatar: "Vika.png", surname: "Авдошина", age:20, birthDate: "1.02.2000", city: "Казань", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(fio: "Анна Иванова", userID: "KJKJKD1", name: "Анна", onlineStatus: "Online", userAvatar: "Anna.png", surname: "Иванова", age:25, birthDate: "3.09.1995", city: "Пенза", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(fio: "Дарья Петрова", userID: "KJKJKD1", name: "Дарья", onlineStatus: "Offline", userAvatar: "Dasha.png", surname: "Петрова", age:21, birthDate: "3.04.1999", city: "Ярославль", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.")]
    
    var sections: [String: [UserInfo]] = [:]
    var keys: [String] = []
    var filteredData = [UserInfo]()
    var searchBarStatus = false
    var imageName = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        
        friendsData.forEach { friend in
            let firstLetter = String(friend.fio.first!)
            if sections[firstLetter] != nil {
                sections[firstLetter]!.append(friend)
            } else {
                sections[firstLetter] = [friend]
            }
        }
        keys = Array(sections.keys).sorted(by: <)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = friendsData.filter ({ (friend: UserInfo) -> Bool in
            return friend.fio.lowercased().contains(searchText.lowercased())
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFriends", for: indexPath) as! TableViewCell
        
        let key = keys[indexPath.section]
        
        if searchBarStatus {
            let searchedFriends = filteredData[indexPath.row]
            cell.friendLabel.text = searchedFriends.fio
            imageName = UIImage(named: searchedFriends.userAvatar)!
        } else {
            let friendsClass = sections[key]![indexPath.row]
            cell.friendLabel.text = friendsClass.fio
            imageName = UIImage(named: friendsClass.userAvatar)!
        }
        
        
        let avatarView: UIView = UIView(frame: CGRect(x: 3, y: 2, width: 42, height: 42))
        let layer = CALayer()
        let image = imageName.cgImage
        layer.frame = avatarView.bounds
        layer.contents = image
        avatarView.layer.addSublayer(layer)
        avatarView.layer.cornerRadius = avatarView.frame.width / 2
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 21, y: 21), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.gray.cgColor
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.lineWidth = 1.0
        
        let roundView = UIView(frame: CGRect(x: 4, y: 3, width: 40, height: 40))
        let circle = CALayer()
        circle.frame = roundView.bounds
        roundView.layer.addSublayer(circleLayer)
        roundView.backgroundColor = UIColor.gray
        roundView.alpha = 1
        roundView.layer.cornerRadius = roundView.frame.width / 2
        roundView.layer.shadowColor = color.cgColor
        roundView.layer.shadowOpacity = opacity
        roundView.layer.shadowRadius = radius
        roundView.layer.shadowOffset = CGSize.zero
        
        avatarView.layer.mask = circleLayer
        
        cell.contentView.addSubview(roundView)
        cell.contentView.addSubview(avatarView)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! ProfileController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let key = keys[indexPath.section]
            
            if searchBarStatus {
                let friendsClass = filteredData[indexPath.row]
                vc.userPhoto = UIImage(named: friendsClass.userAvatar)
                vc.userName = friendsClass.name
                vc.userSurname = friendsClass.surname
                vc.userCity = friendsClass.city
                vc.userBirth = friendsClass.birthDate
                vc.userAge = "\(friendsClass.age)"
                vc.userStatus = friendsClass.onlineStatus
                vc.userBio = friendsClass.bio
            } else {
                let friendsClass = sections[key]![indexPath.row]
                vc.userPhoto = UIImage(named: friendsClass.userAvatar)
                vc.userName = friendsClass.name
                vc.userSurname = friendsClass.surname
                vc.userCity = friendsClass.city
                vc.userBirth = friendsClass.birthDate
                vc.userAge = "\(friendsClass.age)"
                vc.userStatus = friendsClass.onlineStatus
                vc.userBio = friendsClass.bio
            }
            
            

        }
    }
}
