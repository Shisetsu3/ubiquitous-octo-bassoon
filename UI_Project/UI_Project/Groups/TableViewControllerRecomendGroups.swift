//
//  TableViewControllerRecomendGroups.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit
import RealmSwift

class TableViewControllerRecomendGroups: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var sendData: [Groups] = []
    var sendRealmData: Results<Groups>?
    var filteredData = [Groups]()
    var searchBarStatus = false
    var imageGroup = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroup(searchTxt: searchText)
        print(filteredData)
        searchBar.showsCancelButton = true
        searchBarStatus = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.placeholder = "Search"
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        searchBarStatus = false
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarStatus {
            return filteredData.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recomendedGroups", for: indexPath) as! TableViewCellRecomendedGroups
        let searchedGroups = sendData[indexPath.row]
        cell.recomendedGroupsLabel.text = searchedGroups.name
        let imageUrlString2 = searchedGroups.photo
        let imageUrl2 = URL(string: imageUrlString2)!
        let imageData2 = try! Data(contentsOf: imageUrl2)
        let imageName2 = UIImage(data: imageData2)!
        imageGroup = imageName2
        cell.recomendedGroupsPhoto.image = imageGroup
        cell.recomendedGroupsPhoto.layer.cornerRadius = cell.recomendedGroupsPhoto.frame.width / 2
        
        return cell
    }
    
    func searchGroup(searchTxt: String) {
        let urlString = "https://api.vk.com/method/groups.search?user_id=\(VKSession.info.userId)&q=\(searchTxt)&count=5&access_token=\(VKSession.info.token)&v=5.130".encodeUrl
        
        let url = URL(string: urlString) //else {return}
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode(Group.self, from: data)
                self.filteredData = jsonData.response.items
                self.sendData = self.filteredData
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error is : \n\(error)")
            }
        }.resume()
    }
}

extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
