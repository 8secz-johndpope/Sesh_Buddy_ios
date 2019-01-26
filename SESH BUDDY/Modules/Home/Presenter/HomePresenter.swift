//
//  SettingsPresenter.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 29/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
  weak var view: HomeViewProtocol?
  var interactor: HomeInteractorInputProtocol?
  var wireFrame: HomeWireFrameProtocol?

    func didTapAtNotifications() {
//        self.wireFrame?.moveToNavigations(fromView: self.view!)
    }
    
    func buddyUpWith(shmokeHandler: SHMOKSessionHandler) -> Session? {
        var seshDataArray = [[String: Any]]()
        if shmokeHandler.selectedSeshType.count == 0 {
            self.view?.showAlert("Please select Sesh Type")
            return nil
        } else {
            let dict = ["key" : "SESH TYPE:", "value": shmokeHandler.selectedSeshType]
            seshDataArray.append(dict)
        }
        if shmokeHandler.selectedStrainType.count == 0 {
            self.view?.showAlert("Please select Strain")
            return nil
        } else {
            let dict = ["key" : "STRAIN:", "value" :  shmokeHandler.selectedStrainType]
            seshDataArray.append(dict)
        }
        if shmokeHandler.selectedDate.count == 0 {
            self.view?.showAlert("Please select Date")
            return nil
        } else {
            let dict = ["key" : "DATE:", "value" :  shmokeHandler.selectedDate]
            seshDataArray.append(dict)
        }
        if shmokeHandler.selectedTime.count == 0 {
            self.view?.showAlert("Please select Time")
            return nil
        } else if !self.validate(date: shmokeHandler.selectedDate, time: shmokeHandler.selectedTime){
            self.view?.showAlert("Please select appropriate time")
            return nil
        } else {
            let dict = ["key" : "TIME:", "value" :  shmokeHandler.selectedTime]
            seshDataArray.append(dict)
        }
        if shmokeHandler.selectedLocation.count == 0 {
            self.view?.showAlert("Please enter location")
            return nil
        } else {
            let dict = ["key" : "LOCATION:", "value" :  shmokeHandler.selectedLocation]
            seshDataArray.append(dict)
        }
        if shmokeHandler.selectedUtensilType.count == 0 {
            self.view?.showAlert("Please select Utensil")
            return nil
        } else {
            let dict = ["key" : "UTENSIL:", "value" :  shmokeHandler.selectedUtensilType]
            seshDataArray.append(dict)
        }

        let seshBuddies = self.removeBlankBuddyFrom(buddyList: shmokeHandler.buddiesList)
        if seshBuddies.count == 0 {
            self.view?.showAlert("Please enter buddies")
            return nil
        }
        let sesssion = ["seshData": seshDataArray,
                        "seshType": SessionType.SHMOKE.rawValue,
                        "userId": "90805fish",
                        "userName": "905fish",
                        "seshBuddies": seshBuddies] as [String : Any]
        
        let sessionsData = Session.modelsFromDictionaryArray(array: [sesssion])
        
        return sessionsData[0]
        
    }
    func removeBlankBuddyFrom(buddyList: [String]) -> [[String: Any]]  {
        var buddies = [[String: Any]]()
        let newArray =  buddyList.filter { (text) -> Bool in
            if !text.isEmpty {
                let dict = ["buddyName": text]
                buddies.append(dict)
                return true
            }
            return false
        }
        if newArray.count > 0 {
            return buddies
        }
        return buddies
    }
    
    func buddyUpWith(matchHandler: MatchSessionHandler) -> Session? {
        var seshDataArray = [[String: Any]]()
        if matchHandler.selectedSeshType.count == 0 {
            self.view?.showAlert("Please select Sesh Type")
            return nil
        } else {
            let dict = ["key" : "SESH TYPE:", "value" : matchHandler.selectedSeshType]
            seshDataArray.append(dict)
        }
        if matchHandler.selectedGramType.count == 0 {
            self.view?.showAlert("Please select Gram Type")
            return nil
        } else {
            let dict = ["key": "GRAM:", "value": matchHandler.selectedGramType]
            seshDataArray.append(dict)
        }
        if matchHandler.selectedStrainType.count == 0 {
            self.view?.showAlert("Please select Strain")
            return nil
        } else {
            let dict = ["key" : "STRAIN:", "value" :  matchHandler.selectedStrainType]
            seshDataArray.append(dict)
        }
        if matchHandler.selectedDate.count == 0 {
            self.view?.showAlert("Please select Date")
            return nil
        } else {
            let dict = ["key" : "DATE:", "value" :  matchHandler.selectedDate]
            seshDataArray.append(dict)
        }
        if matchHandler.selectedTime.count == 0 {
            self.view?.showAlert("Please select Time")
            return nil
        } else if !self.validate(date: matchHandler.selectedDate, time: matchHandler.selectedTime){
            self.view?.showAlert("Please select appropriate time")
            return nil
        } else {
            let dict = ["key" : "TIME:", "value" :  matchHandler.selectedTime]
            seshDataArray.append(dict)
        }
        if matchHandler.selectedLocation.count == 0 {
            self.view?.showAlert("Please enter location")
            return nil
        } else {
            let dict = ["key" : "LOCATION:", "value" :  matchHandler.selectedLocation]
            seshDataArray.append(dict)
        }
        if matchHandler.selectedUtensilType.count == 0 {
            self.view?.showAlert("Please select Utensil")
            return nil
        } else {
            let dict = ["key" : "UTENSIL:", "value" :  matchHandler.selectedUtensilType]
            seshDataArray.append(dict)
        }
        
          let seshBuddies = self.removeBlankBuddyFrom(buddyList: matchHandler.buddiesList)
        if seshBuddies.count == 0 {
            self.view?.showAlert("Please enter buddies")
            return nil
        }
        let sesssion = ["seshData": seshDataArray,
                        "seshType": SessionType.MATCH.rawValue,
                        "userId": "90805fish",
                        "userName": "905fish",
                        "seshBuddies": seshBuddies] as [String : Any]
        
        let sessionsData = Session.modelsFromDictionaryArray(array: [sesssion])
        return sessionsData[0]
    }
    func buddyUpWith(dropHandler: DropSessionHandler)  -> Session?{
        var seshDataArray = [[String: Any]]()
        if dropHandler.selectedSeshType.count == 0 {
            self.view?.showAlert("Please select Sesh Type")
            return nil
        } else {
            let dict = ["key" : "SESH TYPE:", "value" :  dropHandler.selectedSeshType]
            seshDataArray.append(dict)
        }
        if dropHandler.selectedStrainType.count == 0 {
            self.view?.showAlert("Please select Strain")
            return nil
        } else {
            let dict = ["key" : "STRAIN:", "value" :  dropHandler.selectedStrainType]
            seshDataArray.append(dict)
        }
        if dropHandler.selectedPointType.count == 0 {
            self.view?.showAlert("Please select POINTS")
            return nil
        } else {
            let dict = ["key" : "POINTS:", "value" :  dropHandler.selectedPointType]
            seshDataArray.append(dict)
        }
        if dropHandler.selectedDate.count == 0 {
            self.view?.showAlert("Please select Date")
            return nil
        } else {
            let dict = ["key" : "DATE:", "value" :  dropHandler.selectedDate]
            seshDataArray.append(dict)
        }
        
        if dropHandler.selectedTime.count == 0 {
            self.view?.showAlert("Please select Time")
            return nil
        } else if !self.validate(date: dropHandler.selectedDate, time: dropHandler.selectedTime){
            self.view?.showAlert("Please select appropriate time")
            return nil
        } else {
            let dict = ["key" : "TIME:", "value" :  dropHandler.selectedTime]
            seshDataArray.append(dict)
        }
        if dropHandler.selectedLocation.count == 0 {
            self.view?.showAlert("Please enter location")
            return nil
        } else {
            let dict = ["key" : "LOCATION:", "value" :  dropHandler.selectedLocation]
            seshDataArray.append(dict)
        }
        if dropHandler.selectedUtensilType.count == 0 {
            self.view?.showAlert("Please select Utensil")
            return nil
        } else {
            let dict = ["key" : "UTENSIL:", "value" :  dropHandler.selectedUtensilType]
            seshDataArray.append(dict)
        }
        let seshBuddies = self.removeBlankBuddyFrom(buddyList: dropHandler.buddiesList)
        if seshBuddies.count == 0 {
            self.view?.showAlert("Please enter buddies")
            return nil
        }
        let sesssion = ["seshData": seshDataArray,
                        "seshType": SessionType.SHMOKE.rawValue,
                        "userId": "90805fish",
                        "userName": "905fish",
                        "seshBuddies": seshBuddies] as [String : Any]
        
        let sessionsData = Session.modelsFromDictionaryArray(array: [sesssion])
        return sessionsData[0]
    }
   func buddyUpWith(smoHandler: SMOSssionHandler) -> Session? {
    var seshDataArray = [[String: Any]]()
    if smoHandler.selectedSeshType.count == 0 {
        self.view?.showAlert("Please select Sesh Type")
        return nil
    } else {
        let dict = ["key" : "SESH TYPE:", "value" :  smoHandler.selectedSeshType]
        seshDataArray.append(dict)
    }
    if smoHandler.selectedReasonsType.count == 0 {
        self.view?.showAlert("Please select Strain")
        return nil
    } else {
        let dict = ["key" : "REASON:", "value" :  smoHandler.selectedReasonsType]
        seshDataArray.append(dict)
    }
    if smoHandler.selectedDate.count == 0 {
        self.view?.showAlert("Please select Date")
        return nil
    } else {
        let dict = ["key" : "DATE:", "value" :  smoHandler.selectedDate]
        seshDataArray.append(dict)
    }
    if smoHandler.selectedTime.count == 0 {
        self.view?.showAlert("Please select Time")
        return nil
    } else if !self.validate(date: smoHandler.selectedDate, time: smoHandler.selectedTime){
       self.view?.showAlert("Please select appropriate time")
        return nil
    } else {
        let dict = ["key" : "TIME:", "value" :  smoHandler.selectedTime]
        seshDataArray.append(dict)
    }
    if smoHandler.selectedLocation.count == 0 {
        self.view?.showAlert("Please enter location")
        return nil
    } else {
        let dict = ["key" : "LOCATION:", "value" :  smoHandler.selectedLocation]
        seshDataArray.append(dict)
    }
    let seshBuddies = self.removeBlankBuddyFrom(buddyList: smoHandler.buddiesList)
    
    if seshBuddies.count == 0 {
        self.view?.showAlert("Please enter buddies")
        return nil
    }
        
    
    let sesssion = ["seshData": seshDataArray,
                    "seshType": SessionType.SMO.rawValue,
                    "userId": "90805fish",
                    "userName": "905fish",
                    "seshBuddies": seshBuddies] as [String : Any]
    
    let sessionsData = Session.modelsFromDictionaryArray(array: [sesssion])
    return sessionsData[0]
    }
    func validate(date: String, time: String)-> Bool {
        var dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .long
        let dateFromTimeString = dateFormatter.date(from: time)
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        if dateFromTimeString == nil {
            return false
        }
        let timeString = dateFormatter.string(from: dateFromTimeString!)
        let completeDateString = date + " " + timeString
        let formate = sessionDateFormate + " " + "hh:mm a"
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        
        
        let currentDateString = dateFormatter.string(from: Date())
        let currentDateWithFormatter = dateFormatter.date(from: currentDateString)
        let selectedDate = dateFormatter.date(from: completeDateString)
        
        if currentDateWithFormatter != nil, selectedDate != nil, selectedDate!.compare(currentDateWithFormatter!) == .orderedDescending {
            return true
        }
        return false
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
  func onError(value: String) {
    
  }
  
  func generatedOtpWith(_ value: ServerResponseModal) {
    
//      guard let data = value.response, let flag = value.flag  else {
//
//        if let message = value.message {
//          self.view?.showAlert(message)
//        } else {
//          if let message = value.error {
//            self.view?.showAlert(message)
//          }
//        }
//
//        return
//      }
//
//      switch flag {
//      case let x where x == RESPONSE_FLAGS.flag_143 || x == RESPONSE_FLAGS.VERIFICATION_REQUIRED:
//        var otpdata = OTPData.init(fromDictionary: data)
//        otpdata.addPhone(phoneNumber)
//        otpdata.addCountryCode(countryCode)
//        wireFrame?.showVerificationScreen(from: view!, with: otpdata)
//      default:
//        if let message = value.message {
//          self.view?.showAlert(message)
//        } else {
//          if let message = value.error {
//            self.view?.showAlert(message)
//          }
//        }
//      }
    }
  
  }
    
    

