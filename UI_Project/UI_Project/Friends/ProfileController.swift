//
//  ProfileController.swift
//  UI_Project
//
//  Created by Shisetsu on 21.12.2020.
//

import UIKit

class ProfileController: UIViewController {
    
    var userPhoto: UIImage!
    var photoArray = [Size]()
    var userName: String!
    var userSurname: String!
    var userCity: String!
    var userBirth: String!
    var userAge: String!
    var userStatus: String!
    var userBio: String!
    var userID = String()
    //var userGalery:[UIImage]!
    
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var bio: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhoto()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(tapGestureRecognizer)
        
        avatar.image = userPhoto
        name.text = userName
        surname.text = userSurname
        city.text = userCity
        birthDate.text = userBirth
        age.text = userAge
        status.text = userStatus
        if status.text == "Offline" {
            status.textColor = UIColor.red
        } else {
            status.textColor = UIColor.green
        }
        bio.text = userBio
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoGallery") as! CollectionViewController
        //vc.avatar = avatar.image
        vc.userID = userID
        vc.userPhoto = photoArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getPhoto() {
        let url = URL(string:"https://api.vk.com/method/photos.getAll?owner_id=\(userID)&photo_sizes=0&access_token=\(VKSession.info.token)&v=5.126")

        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8))
            do {
                let jsonData = try JSONDecoder().decode(Item3.self, from: data)
                // на данный момент тут косяк, не корректная выгрузка из-за чего пока пустота пока в фото :(
                self.photoArray = jsonData.sizes
                print(jsonData)
            } catch {
                print("Error is : \n\(error)")
            }
        }.resume()
    }
}
