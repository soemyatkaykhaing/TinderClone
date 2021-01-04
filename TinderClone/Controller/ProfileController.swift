//
//  ProfileController.swift
//  TinderClone
//
//  Created by MacBook on 31/10/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
private let reuseIdentifier = "ProfileCell"
class ProfileController: UIViewController {
    // MARK: -Properties
    private let user: User
    private lazy var barStackView = SegmentedBarView(numberOfSegment: viewModel.imageURLs.count)

    private lazy var viewModel = ProfileViewModel(user: user)
    private lazy var collectionView : UICollectionView = {
        let frame = CGRect(x: 0,y: 0, width: view.frame.width,height: view.frame.width)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    private let blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blur)
        return view
    }()
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "dismiss_down_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        button.target(forAction: #selector(handleDismissal), withSender: self)
        
        return button
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Actress"
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "I was in transformers"
        return label
    }()
    private lazy var dislikeButton: UIButton = {
        let button = createButton(withImage: #imageLiteral(resourceName: "dismiss_circle"))
        button.target(forAction: #selector(handleDislike), withSender: self)
        return button
    }()
    private lazy var superLikeButton: UIButton = {
        let button = createButton(withImage: #imageLiteral(resourceName: "super_like_circle"))
        button.target(forAction: #selector(handleSuperLike), withSender: self)
        return button
    }()
    private lazy var likeButton: UIButton = {
        let button = createButton(withImage: #imageLiteral(resourceName: "like_circle"))
        button.target(forAction: #selector(handleLike), withSender: self)
        return button
    }()
    init(user: User){
        self.user = user
        super.init(nibName: nil,bundle: nil)
    }
    
    // MARK: - Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadUserData()
    }
    //MARK: - Actions
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    @objc func handleDislike() {
        
    }
    @objc func handleSuperLike() {
        
    }
    @objc func handleLike() {
        
    }
    //MARK: -Helpers
    func loadUserData() {
        infoLabel.attributedText = viewModel.userDetailsAttributedString
        professionLabel.text = viewModel.profession
        bioLabel.text = viewModel.bio
    }
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        dismissButton.setDimensions(height: 40, width: 40)
        dismissButton.anchor(top: collectionView.bottomAnchor,right: view.rightAnchor,paddingTop: -20,paddingRight: 16)
        let infoStack = UIStackView(arrangedSubviews: [infoLabel,professionLabel,bioLabel])
        infoStack.spacing = 4
        view.addSubview(infoStack)
        infoStack.anchor(top: collectionView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 12,paddingLeft: 12,paddingRight: 12)
        blurView.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 56,paddingLeft: 8,paddingRight: 8, height: 4)
        view.addSubview(blurView)
        configureBottomControls()
        configureBarStackView()
        
        
    }
    func configureBarStackView() {
        view.addSubview(barStackView)
        barStackView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 56, paddingLeft: 8, paddingRight: 8, height: 4)
    }
    func configureBottomControls() {
        let stack = UIStackView(arrangedSubviews: [dislikeButton,superLikeButton,likeButton])
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.spacing = -32
        stack.setDimensions(height: 80, width: 300)
        stack.centerX(inView: view)
        stack.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 32)
    }
    func createButton(withImage image: UIImage) -> UIButton{
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
}
//MARK: - UIcollectionviewDelegate
extension ProfileController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        cell.imageView.sd_setImage(with: viewModel.imageURLs[indexPath.row])
        return cell
    }
}
extension ProfileController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        barStackView.setHighLighted(index: indexPath.row)
        
    }
}
//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.width + 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
