//
//  TableViewControllerRecomendGroups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

class TableViewControllerRecomendGroups: UITableViewController {
    
    let userReccomendGroups = ["Книжный", "Бары", "Музыка", "Сериалы", "Кино-новинки", "Новости твоего города", "Игры"]
    let recGroupPics = ["Books.png", "Pub.png", "Music.png", "Serials.png", "Cinema.png", "News.jpg", "Games.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userReccomendGroups.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recomendedGroups", for: indexPath) as! TableViewCellRecomendedGroups
        cell.recomendedGroupsLabel.text = "\(self.userReccomendGroups[indexPath.row])"
        let imageGroup = "\(self.recGroupPics[indexPath.row])"
        cell.recomendedGroupsPhoto.image = UIImage(named: imageGroup)
        cell.recomendedGroupsPhoto.layer.cornerRadius = cell.recomendedGroupsPhoto.frame.width / 2
        return cell
    }
}
