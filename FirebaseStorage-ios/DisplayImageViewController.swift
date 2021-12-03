//
//  DisplayImageViewController.swift
//  FirebaseStorage-ios
//
//  Created by 伊藤明孝 on 2021/11/21.
//

import UIKit
import Firebase
import FirebaseStorage

class DisplayImageViewController: UIViewController {
    
    let storageRef = Storage.storage().reference(forURL: "gs://fir-storage-ios-f8060.appspot.com")

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.layer.cornerRadius = 100
        imageView.contentMode = .scaleAspectFill
        
        let imagesRef = storageRef.child("profile").child("userImage.jpeg")
        
        imagesRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("画像の取り出しに失敗: \(error)")
            }else{
                let image = UIImage(data: data!)
                self.imageView.image = image
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
