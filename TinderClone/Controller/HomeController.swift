//
//  HomeController.swift
//  TinderClone
//
//  Created by MacBook on 07/07/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class HomeController: UIViewController{
    //MARK: - Properties
    private var user: User?
    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlStackView()
    private var viewModels = [CardViewModel]() {
        didSet { configureCards() }
    }
    private let deckView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
   
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        
        fetchUsers()
        fetchUser()
        
        configureUI()
       // logout()
    }
    //MARK: API
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { (user) in
            
            self.user = user
        }
    }
    func fetchUsers() {
        Service.fetchUsers { (users) in
            self.viewModels = users.map( {CardViewModel(user: $0)} )
            
        }
    }
       func checkIfUserIsLoggedIn() {
           if Auth.auth().currentUser == nil {
               presentLoginController()
           } else{
               print("DEBUD: User is loggin in")
           }
    }
    func logout() {
        do {
            try Auth.auth().signOut()
                presentLoginController()
        } catch{
            print("DEBUG: Failed to sign out..")
        }
    }
    //MARK: - Helpers
    func configureCards(){
        viewModels.forEach{ viewModel in
            let cardView = CardView(viewModel: viewModel)
            cardView.delegate = self
            deckView.addSubview(cardView)
            cardView.fillSuperview()
            
        }
    }
    func configureUI(){
        view.backgroundColor = .white
        topStack.delegate = self
        bottomStack.delegate = self
        let stack = UIStackView(arrangedSubviews: [topStack,deckView,bottomStack])
        stack.axis = .vertical
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0,left: 12,bottom: 0,right: 12)
        stack.bringSubviewToFront(deckView)
    }
    func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}

//MARK: - HomeNavigationStackViewDelegate
extension HomeController: HomeNavigationStackViewDelegate{
    func showSettings() {
        guard let user = self.user else {
            return
        }
       
        let controller = SettingsController(user: user)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true,completion: nil)
    }
    
    func showMessages() {
        
    }
    
}
extension HomeController: SettingControllerDelegate {
    func settingsControllerWantsToLogout(_ controller: SettingsController) {
        controller.dismiss(animated: true, completion: nil)
        logout()
    }
    
    func settingsController(_ controller: SettingsController, wantsToUpate user: User){
        controller.dismiss(animated: true,completion: nil)
        self.user = user
    }
}

extension HomeController: CardViewDelegate {
    func cardView(_ view: CardView, wantsToShowProfileFor user: User) {
        let controller = ProfileController(user: user)
        controller.modalPresentationStyle = .fullScreen
        present(controller,animated: true,completion: nil)
    }
}

extension HomeController: BottomControlStackViewDelegate {
    func handleLike() {
        <#code#>
    }
    
    func handleDislike() {
        <#code#>
    }
    
    func handleRefresh() {
        <#code#>
    }
    
    
}
