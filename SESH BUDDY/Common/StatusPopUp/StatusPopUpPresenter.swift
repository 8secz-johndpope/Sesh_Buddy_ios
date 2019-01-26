//
//  StatusPopUpPresenter.swift
//  SESH BUDDY
//
//  Created by test on 15/12/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

import Foundation
import Alamofire

class StatusPopUpPresenter: NSObject {
    static let share = StatusPopUpPresenter()
    func changeUserStatus(_ type: StatusTypes, callback: @escaping (_ response: ServerResponseModal) -> Void ) {
        let param: [String: Any] = [ParametersKeys.userStatus: type.rawValue]
        HTTPRequest.init(method: HTTPMethod.post, path: Urls.updateUserStatus, parameters: param, encoding: .json, files: nil)
            .config(isIndicatorEnable: true, isAlertEnable: true).headers(headers: AppInfo.getHeader())
            .handler(httpModel: false) { (response: HTTPResponse) in
                print(response.value ?? "No result")
                let serverResponse = response.getServerResponseModal()
                callback(serverResponse)
        }
    }
    
}
