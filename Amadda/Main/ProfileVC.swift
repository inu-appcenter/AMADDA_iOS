//
//  ProfileVC.swift
//  Amadda
//
//  Created by seunghwan Lee on 2020/03/07.
//  Copyright © 2020 mong. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var majorTextFiled: UITextField!
    
    
    @IBAction func imagePressed(_ sender: Any) {
        selectImageSource()
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        // 네트워크 저장
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func selectImageSource() {
            self.view.endEditing(true)
            
            let source = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
            source.addAction(UIAlertAction(title: "사진 촬영", style: .default, handler: { (_) in
                self.presentPicker(source: .camera)
            }))
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            source.addAction(UIAlertAction(title: "라이브러리에서 선택", style: .default, handler: { (_) in
                self.presentPicker(source: .photoLibrary)
                   }))
            }
            
            source.addAction(UIAlertAction(title: "기본 이미지로 변경", style: .default, handler: { (_) in
                    self.profileImg.image = UIImage(named: "icon_profile")
               }))
        
            source.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            
            self.present(source, animated: true)
        }
    }
    

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func presentPicker(source: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        self.present(picker, animated: false)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let selectedImg = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImg.image = selectedImg
      }
      picker.dismiss(animated: false)
    }

}
