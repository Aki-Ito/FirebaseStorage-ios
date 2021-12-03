//
//  SelectImageViewController.swift
//  FirebaseStorage-ios
//
//  Created by 伊藤明孝 on 2021/11/21.
//

import UIKit
import Firebase
import FirebaseStorage

//画像を選択
class SelectImageViewController: UIViewController {
    
    
    @IBOutlet weak var profileButton: UIButton!
    
    let storageRef = Storage.storage().reference(forURL: "gs://fir-storage-ios-f8060.appspot.com")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileButton.layer.borderWidth = 1
        profileButton.layer.cornerRadius = 100
        profileButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tappedProfileButton(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func tappedSaveButton(_ sender: Any) {
        //ボタンからimageを取り出してjpgデータに変換する。
        guard let image = profileButton.imageView?.image else {
            return
        }
        
        guard let uploadImage = image.jpegData(compressionQuality: 0.2) else {
            return
        }
        
        let imagesRef = storageRef.child("profile").child("userImage.jpeg")
        
        imagesRef.putData(uploadImage, metadata: nil) { metaData, error in
            if let error = error {
                print("画像の保存に失敗しました: \(error)")
            }
        }
        
    }
    
}

extension SelectImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //サイズなどを変えた際に受け取るイメージ
        if let image = info[.editedImage] as? UIImage{
            profileButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            //大きさが何も変わっていない
        }else if let originalImage = info[.originalImage] as? UIImage{
            profileButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        profileButton.setTitle("", for: .normal)
        profileButton.imageView?.contentMode = .scaleAspectFill
        profileButton.contentHorizontalAlignment = .fill
        profileButton.contentVerticalAlignment = .fill
        profileButton.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}
