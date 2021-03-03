//
//  ProfileController.swift
//  UI_Project
//
//  Created by Shisetsu on 21.12.2020.
//

import UIKit
import RealmSwift
import SwiftyJSON
import SwiftyVK

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
    var userID = Int()
    
    
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
        DispatchQueue.main.async() {
            self.loadPhotoData()
        }
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
        vc.userID = userID
        vc.userPhoto = photoArray
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func savePhotoData(_ photos: [Size]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photos, update: .modified)
            try realm.commitWrite()
            //            print("URL FOR BASE")
            //            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
//    func createUserId(userId: Int) {
//        do {
//            let realm = try Realm()
//            realm.beginWrite()
//            realm.add(photos)
//            try realm.commitWrite()
//            //            print("URL FOR BASE")
//            //            print(realm.configuration.fileURL!)
//        } catch {
//            print(error)
//        }
//    }
    
    func loadPhotoData() {
        do {
            let realm = try Realm()
            let photo = realm.objects(Size.self)
            self.photoArray = Array(photo)
        } catch {
            print(error)
        }
    }
    
    func getPhoto() {
        let url = URL(string:"https://api.vk.com/method/photos.get?owner_id=\(userID)&album_id=profile&count=1&photo_sizes=1&access_token=\(VKSession.info.token)&v=5.130")
        print(url!)
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            do {
                let jsonData = try JSONDecoder().decode(Photo.self, from: data).response
                
                var array = [Item3]()
                array = jsonData.items
                var sizesArray = [Size]()
                var i = array.makeIterator()
                while let photos = i.next() {
                    sizesArray.append(contentsOf: photos.sizes)
                }
                self.savePhotoData(sizesArray)
            } catch {
                print("Error is : \n\(error)")
            }
        }.resume()
    }
}
