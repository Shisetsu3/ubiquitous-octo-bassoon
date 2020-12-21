//
//  FriendsTableController.swift
//  UI_Project
//
//  Created by Shisetsu on 11.12.2020.
//

import UIKit

@IBDesignable class FriendsTableController: UITableViewController {
    
    @IBInspectable var opacity:Float = 0.5
    @IBInspectable var radius:CGFloat = 0
    @IBInspectable var color:UIColor = .gray
    
    var friendsData = [
        UserInfo(userID: "GHAVR6R", onlineStatus: "Online", userAvatar: "Petya.png", name: "Петр", surname: "Иванов", age: 25, birthDate: "13.01.1995", city: "Москва", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(userID: "NNBAGBB", onlineStatus: "Offline", userAvatar: "Vasya.png", name: "Василий", surname: "Сидоров", age: 32, birthDate: "19.02.1988", city: "Воронеж", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(userID: "BBSJLOP", onlineStatus: "Offline", userAvatar: "Fedor.png", name: "Федор", surname: "Горюнов", age:40, birthDate: "10.07.1980", city: "Санкт-Петербург", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(userID: "VW5PFLM", onlineStatus: "Online", userAvatar: "Vova.png", name: "Владимир", surname: "Сегреев", age:18, birthDate: "13.03.2002", city: "Нижний Новгород", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(userID: "MNDBJ76", onlineStatus: "Online", userAvatar: "Viktor.png", name: "Виктор", surname: "Бунин", age:28, birthDate: "18.05.1992", city: "Псков", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(userID: "KJKJKD1", onlineStatus: "Offline", userAvatar: "Vika.png", name: "Виктория", surname: "Авдошина", age:20, birthDate: "1.02.2000", city: "Казань", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(userID: "KJKJKD1", onlineStatus: "Online", userAvatar: "Anna.png", name: "Анна", surname: "Иванова", age:25, birthDate: "3.09.1995", city: "Пенза", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus."),
        UserInfo(userID: "KJKJKD1", onlineStatus: "Offline", userAvatar: "Dasha.png", name: "Дарья", surname: "Петрова", age:21, birthDate: "3.04.1999", city: "Ярославль", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque auctor, velit vel condimentum euismod, arcu magna fermentum augue, ac cursus lectus elit et nunc. Praesent vitae varius risus.")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsData.count - 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFriends", for: indexPath) as! TableViewCellOnline
        
        let friendsClass = friendsData[indexPath.row]
        
        cell.friendLabel.text = friendsClass.name
        cell.surnameLabel.text = friendsClass.surname
        
        let imageName = UIImage(named: friendsClass.userAvatar)
        
        
        let avatarView: UIView = UIView(frame: CGRect(x: 3, y: 2, width: 42, height: 42))
        let layer = CALayer()
        let image = imageName?.cgImage
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
            let friendsClass = friendsData[indexPath.row]
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
