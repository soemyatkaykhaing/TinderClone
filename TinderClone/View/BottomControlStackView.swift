//
//  BottomControlStackView.swift
//  TinderClone
//
//  Created by MacBook on 07/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
class BottomControlStackView: UIStackView {
    //MARK: -Properties
    
    let refreshButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let superlikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
    let boostButton = UIButton(type: .system)
    //MARK: -Liftecyle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        refreshButton.setImage(#imageLiteral(resourceName: "refresh_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.setImage(#imageLiteral(resourceName: "dismiss_circle").withRenderingMode(.alwaysOriginal), for: .normal)
        superlikeButton.setImage(#imageLiteral(resourceName: "super_like_circle").withRenderingMode(.alwaysOriginal),for: .normal)
        likeButton.setImage(#imageLiteral(resourceName: "like_circle").withRenderingMode(.alwaysOriginal),for: .normal)
        boostButton.setImage(#imageLiteral(resourceName: "boost_circle").withRenderingMode(.alwaysOriginal),for: .normal)
        
        [refreshButton, dislikeButton, superlikeButton, likeButton, boostButton].forEach { (view) in
            addArrangedSubview(view)
        }
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
