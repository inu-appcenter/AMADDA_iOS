//
//  invitationVC.swift
//  Amadda
//
//  Created by mong on 2020/08/29.
//  Copyright © 2020 mong. All rights reserved.
//

import Foundation
import UIKit

class InvitaionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvitationCell", for: indexPath) as? InvitationCell else {return UICollectionViewCell()}
        cell.groupName.text = "testGroup"
        cell.memoLabel.text = "testMEmo"
        cell.acceptBtn.addTarget(self, action: #selector(accept), for: .touchUpInside)
        
        return cell
    }
    
    @objc func accept() {
        print("accept")
    }
}
