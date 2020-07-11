//
//  CardView.swift
//  TinderClone
//
//  Created by MacBook on 07/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
enum SwipeDirection: Int {
    case left = -1
    case right = 1
}
class CardView: UIView {
    //MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    private let viewModel: CardViewModel
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "lady4c")
        return iv
    }()
    private lazy var infoLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = viewModel.userInfoText
        return label
    }()
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    //MARK: - Lifecycle
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureGestureRecognizers()
        imageView.image = viewModel.user.images.first
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
    //MARK: - Actions
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations()
            })
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default: break
        }
    }
    @objc func handleChangePhoto(sender: UITapGestureRecognizer){
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        }else{
            viewModel.showPreviousPhoto()
        }
        imageView.image = viewModel.imageToShow
    }
    //MARK: - Helpers
    func panCard(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    func resetCardPosition(sender: UIPanGestureRecognizer){
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 100
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            }else{
                self.transform = .identity
            }
        }) { _ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5,1.1]
        layer.addSublayer(gradientLayer)
    }
    func configureGestureRecognizers(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
}
