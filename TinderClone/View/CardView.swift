//
//  CardView.swift
//  TinderClone
//
//  Created by MacBook on 07/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
class CardView: UIView {
    //MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "lady4c")
        return iv
    }()
    private let infoLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Jane Doe", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: " 20", attributes: [.font: UIFont.systemFont(ofSize: 24),.foregroundColor: UIColor.white]))
        label.attributedText = attributedText
        return label
    }()
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
       
        addSubview(imageView)
        configureGradientLayer()
        addSubview(infoLable)
        infoLable.anchor(left: leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingLeft: 16,paddingBottom: 16, paddingRight: 16)
        imageView.fillSuperview()
        addSubview(infoButton)
        infoButton.setDimensions(height: 48, width: 48)
        infoButton.centerY(inView: infoLable)
        infoButton.anchor(right: rightAnchor,paddingRight: 16)
        //configureGradientLayer()
    }
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.1]
        layer.addSublayer(gradientLayer)
    }
}
