//
//  CardViewModel.swift
//  TinderClone
//
//  Created by MacBook on 10/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
class CardViewModel {
    let user: User
    let imageURLs: [String]
    let userInfoText: NSAttributedString
    private var imageIndex = 0
    var index: Int { return imageIndex}
    var imageUrl: URL?
    init(user: User){
        self.user = user
        let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "\(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24),.foregroundColor: UIColor.white]))
        self.userInfoText = attributedText
        self.imageURLs = user.imageURLs
        self.imageUrl = URL(string: user.imageURLs[0])
        
    }
    func showNextPhoto() {
     guard imageIndex < imageURLs.count - 1 else {
          return
       }
       imageIndex += 1
       imageUrl = URL(string: imageURLs[imageIndex])
    }
    func showPreviousPhoto() {
        guard imageIndex > 0 else {
            return
        }
        imageIndex -= 1
        imageUrl = URL(string: imageURLs[imageIndex])
    }
}
