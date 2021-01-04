//
//  ProfileCell.swift
//  TinderClone
//
//  Created by MacBook on 21/11/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
class ProfileCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "jane1")
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
