//
// Created by VIPER
// Copyright (c) 2018 VIPER. All rights reserved.
//

import Foundation
import Alamofire

class BuddyProfileInteractor: BuddyProfileInteractorInputProtocol
{
    weak var presenter: BuddyProfileInteractorOutputProtocol?
    var APIDataManager: BuddyProfileAPIDataManagerInputProtocol?
    var localDatamanager: BuddyProfileLocalDataManagerInputProtocol?
    
    init() {}
    
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
}
