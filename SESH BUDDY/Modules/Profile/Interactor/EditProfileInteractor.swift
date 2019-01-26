//
//  LoginInteractor.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import Alamofire

class EditProfileInteractor: EditProfileInteractorInputProtocol {
    

  var presenter: EditProfileInteractorOutputProtocol?
    let header = [ParametersKeys.platform : "1",
                  ParametersKeys.accessToken: KeyChain.getAccessToken() ?? "",
                  ParametersKeys.userId: "\(ApplicationData.shared.getLoginData().userId!)"
        ] as [String : String]
  func generateOtpWith(_ params: [String: Any]) {
  }
    func logoutFromApp() {
        
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.logout, parameters: nil, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: header)
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                if response.value == nil {
                    self.presenter?.onError(value: "Please check your internet connection")
                } else {
                     self.presenter?.logoutUserWith(serverResponse)
                }
        }
    }
    func editProfileImage(image: UIImage, type: ImageType) {
        let imageData:Data!
        if UIImageJPEGRepresentation(image, 1.0)!.count > 3*1024 {
            imageData = UIImageJPEGRepresentation(image, 0.1)
        }
        else if UIImageJPEGRepresentation(image, 1.0)!.count > 2*1024 {
            imageData = UIImageJPEGRepresentation(image, 0.5)
        }
        else {
            imageData = UIImageJPEGRepresentation(image, 0.75)
        }
        let fileName = "image.jpg"
        let file = CLFile.init(data: imageData, name: ParametersKeys.img_pic, fileName: fileName, mimeType: "image/jpeg")
        
        
        let params = [
                      ParametersKeys.imageType: type.rawValue
                      ] as [String : Any]
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.updateImage, parameters: params, encoding: .json, files: [file])
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: AppInfo.getHeader())
            .multipartHandler(httpModel: false, delay: 0.0) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                self.presenter?.updateProfileImage(serverResponse, type: type)
                
        }
    }
    func editProfileWith(_ params: [String : Any]) {
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.editProfile, parameters: params, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: header)
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                if response.value == nil {
                    self.presenter?.onError(value: "Please check your internet connection")
                } else {
                    self.presenter?.updateProfileWith(serverResponse)
                }
        }
    }
    
}

extension EditProfileInteractor: EditProfileDataManagerOutputProtocol {
  func onError(value: String) {
    
  }
  
  func generatedOtpWith(_ value: ServerResponseModal) {
    presenter?.generatedOtpWith(value)
  }
   
}
