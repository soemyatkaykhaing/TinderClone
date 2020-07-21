//
//  HomeNavigationStackView.swift
//  TinderClone
//
//  Created by MacBook on 07/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
protocol HomeNavigationStackViewDelegate: class {
    func showSettings()
    func showMessages()
}
class HomeNavigationStackView: UIStackView {
    //MARK: -Properties
    weak var delegate: HomeNavigationStackViewDelegate?
    let settingButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))
    
    //MARK: -Liftecyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        settingButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "top_messages_icon").withRenderingMode(.alwaysOriginal),for: .normal)
        [settingButton, UIView(), tinderIcon, UIView(), messageButton].forEach { (view) in
            addArrangedSubview(view)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        settingButton.addTarget(self, action: #selector(handleShowSettings), for: .touchUpInside)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleShowSettings(){
        
    }
    @objc func handleMessages(){
        
    }
}
