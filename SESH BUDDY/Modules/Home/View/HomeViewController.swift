//
//  HomeViewController.swift
//  SESH BUDDY
//
//  Created by Rahish Kansal on 05/09/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var shmokeButton: UIButton!
    @IBOutlet weak var smoButton: UIButton!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var matchButton: UIButton!
    
    var menuBarButton = UIBarButtonItem()
    var presenter: HomePresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializePresenter()
        self.changeStyle(.default)
        self.showMenuBarButton(true)
        self.setNavBarRightButton(type: .plus)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        
    }
    
    
    
    func initializePresenter() {
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol & HomeDataManagerOutputProtocol = HomeInteractor()
        let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
        self.presenter = presenter
        presenter.view = self
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavBarTitleView(image: ThemeImages.appLogo)
        self.changeNavBarColor(.themeNavBarColor)
    }
//
//    func setUPButtonUI() {
//        shmokeButton.layer.borderColor = UIColor.white.cgColor
//        smoButton.layer.borderColor = UIColor.white.cgColor
//        matchButton.layer.borderColor = UIColor.white.cgColor
//        dropButton.layer.borderColor = UIColor.white.cgColor
//
//        shmokeButton.layer.borderWidth = 1
//        smoButton.layer.borderWidth = 1
//        matchButton.layer.borderWidth = 1
//        dropButton.layer.borderWidth = 1
//
//        let font = Fonts.mavenProMedium.getFont(17)
//        shmokeButton.titleLabel?.font = font
//        smoButton.titleLabel?.font = font
//        matchButton.titleLabel?.font = font
//        dropButton.titleLabel?.font = font
//
//        shmokeButton.setTitleColor(.white, for: .normal)
//        smoButton.setTitleColor(.white, for: .normal)
//        matchButton.setTitleColor(.white, for: .normal)
//        dropButton.setTitleColor(.white, for: .normal)
//
//        shmokeButton.setTitle("SHMOKE", for: .normal)
//        smoButton.setTitle("SMO", for: .normal)
//        matchButton.setTitle("MATCH", for: .normal)
//        dropButton.setTitle("DROP", for: .normal)
//
//        shmokeButton.backgroundColor = UIColor.themeNavBarColor
//        smoButton.backgroundColor = UIColor.themeNavBarColor
//        matchButton.backgroundColor = UIColor.themeNavBarColor
//        dropButton.backgroundColor = UIColor.themeNavBarColor
//
//    }
    
    @IBAction override func menuBarBurronItemAction(_ sender: UIBarButtonItem) {
        self.frostedViewController.presentMenuViewController()
    }
    
    @IBAction func shmokeButtonClicked(_ sender: Any) {
    }
    @IBAction func smoButtonClicked(_ sender: Any) {
    }
    @IBAction func dropButtonClicked(_ sender: Any) {
    }
    @IBAction func matchButtonClicked(_ sender: Any) {
    }
    
}
extension HomeViewController: HomeViewProtocol {
    func onError(value: String) {
        
    }
    func showAlert(_ string: String) {
        
    }
}
