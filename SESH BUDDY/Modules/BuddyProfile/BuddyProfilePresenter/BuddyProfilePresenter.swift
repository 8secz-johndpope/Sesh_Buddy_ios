//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation

class BuddyProfilePresenter: BuddyProfilePresenterProtocol, BuddyProfileInteractorOutputProtocol
{
    var coverPic: String!
    var profilePic: String!
    var aboutMe: String!
    
    func updateProfileImage(_ value: ServerResponseModal, type: ImageType) {
        guard let data = value.data, let status = value.status else {
            if let message = value.message {
                self.view?.showAlert(message)
            } else {
                if value.error.count > 0 {
                    let message = value.error[0]
                    self.view?.showAlert(message)
                }
            }
            return
        }
        
        if status == RESPONSE_STATUS.success {
            let loginData = Login(fromDictionary: value.data as! [String : Any] )
            var previouseLoginData = ApplicationData.shared.getLoginData()
            previouseLoginData.profilePic = loginData.profilePic
            previouseLoginData.coverPic = loginData.coverPic
            ApplicationData.shared.setLoginData(previouseLoginData)
            self.view?.reloadView()
        } else {
            if value.error != nil, value.error.count > 0 {
                let message = value.error[0]
                self.view?.showAlert(message)
            }
        }
    }
    
    func moveToTopSeshBuddies() {
        self.wireFrame?.moveToTopSeshBuddies(self.view!)
    }
    func moveToViewAllRatings() {
        self.wireFrame?.moveToViewAllRatings(self.view!)
    }
    func updatePictureClick(image: UIImage, type: ImageType) {
        self.interactor?.editProfileImage(image: image, type: type)
    }
    weak var view: BuddyProfileViewProtocol?
    var interactor: BuddyProfileInteractorInputProtocol?
    var wireFrame: BuddyProfileWireFrameProtocol?
    
    init() {}
    
}
