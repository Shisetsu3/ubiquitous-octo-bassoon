//
//  FriendsTableController.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

class FriendsTableController: UITableViewController {

    let friends = ["Вася","Петя","Федор","Вова","Витя", "Вика", "Анна","Даша"]
    let friendsPhoto = ["Vasya.jpg", "Petya.jpg","Fedor.jpg", "Vova.jpg", "Viktor.jpg",
                        "Vika.jpg", "Anna.jpg", "Dasha.jpg"]
    var friendPhoto = [UIImage(named: "Vasya.jpg"), UIImage(named: "Petya.jpg"), UIImage(named: "Fedor.jpg"), UIImage(named: "Vova.jpg"), UIImage(named: "Viktor.jpg"), UIImage(named: "Vika.jpg"), UIImage(named: "Anna.jpg"),  UIImage(named: "Dasha.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "userFriends", for: indexPath) as! TableViewCellOnline
            cell.friendLabel.text = "\(self.friends[indexPath.row])"
            
            let imageName = "\(self.friendsPhoto[indexPath.row])"
            cell.friendPhoto.image = UIImage(named: imageName)
            cell.friendPhoto.layer.cornerRadius = cell.friendPhoto.frame.width / 2
            
            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let vc = segue.destination as! CollectionViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                vc.userPhoto = friendPhoto[indexPath.row]
        }
    }
}
