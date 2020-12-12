//
//  TableViewController_Groups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

class TableViewControllerGroups: UITableViewController {

    
    var userGroups = [String] ()
    var groupPics = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userGroups", for: indexPath) as! TableViewCellGroups
        let groups = userGroups[indexPath.row]
        cell.userGroupsLabel.text = groups
        
        let imageGroup = "\(self.groupPics[indexPath.row])"
        cell.userGroupsPhoto.image = UIImage(named: imageGroup)
        cell.userGroupsPhoto.layer.cornerRadius = cell.userGroupsPhoto.frame.width / 2
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            groupPics.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            guard let RecomendedGroups = segue.source as? TableViewControllerRecomendGroups else { return }
            if let indexPath = RecomendedGroups.tableView.indexPathForSelectedRow {
                let groups = RecomendedGroups.userReccomendGroups[indexPath.row]
                let image = RecomendedGroups.recGroupPics[indexPath.row]
                
                if !userGroups.contains(groups) || !groupPics.contains(image){
                    userGroups.append(groups)
                    groupPics.append(image)
                    tableView.reloadData()
                }
            }
        }
    }
}
