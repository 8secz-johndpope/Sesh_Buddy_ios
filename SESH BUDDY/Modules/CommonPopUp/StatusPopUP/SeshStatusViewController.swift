//
//  SeshStatusViewController.swift
//  SESH BUDDY
//
//  Created by test on 15/11/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

protocol SessionStatusViewProtocol {
    func viewSessionClicked(session: Session)
    func crossButtonClicked()
    func seshDetailsButtonClick(session: Session)
}

import UIKit

class SeshStatusViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var seshStatusLabel: UILabel!
    @IBOutlet weak var seshTypeLabel: UILabel!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var sessionStatusVutton: UIButton!
    @IBOutlet weak var viewSessionButton: UIButton!
    @IBOutlet weak var noThanksButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    
    var delegate: SessionStatusViewProtocol?
    var session: Session!
    var userID = ""
    var seshTypeString = ""
    var seshActionType: SessionStatusType = .none
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setUPUI()
    }
    func setUPUI(){
        
        backgroundImageView.isHidden = true
        popupView.backgroundColor = UIColor.themeNavBarColor
        popupView.layer.borderColor = UIColor.themeYellowColor.cgColor
        popupView.layer.borderWidth = 1.0
        let font = Fonts.mavenProBold.getFont(20)
        let sessionButtonFont = Fonts.mavenProMedium.getFont(17)
        seshStatusLabel.font = font
        seshStatusLabel.textColor = UIColor.white
        noThanksButton.backgroundColor = UIColor.themeRed
        noThanksButton.contentEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 40)
        noThanksButton.setTitle("I'LL BE BUSY, THANKS", for: .normal)
        noThanksButton.setTitleColor(UIColor.white, for: .normal)
        viewSessionButton.setTitleColor(UIColor.white, for: .normal)
        viewSessionButton.setTitle("VIEW SESH", for: .normal)
        viewSessionButton.backgroundColor = UIColor.buttonColor
        viewSessionButton.layer.cornerRadius = 2.0
        noThanksButton.layer.cornerRadius = 2.0
        viewSessionButton.titleLabel?.font = sessionButtonFont
        noThanksButton.titleLabel?.font = sessionButtonFont
        
        sessionStatusVutton.backgroundColor = UIColor.themeYellowColor
        sessionStatusVutton.setTitleColor(UIColor.buttonColor, for: .normal)
        sessionStatusVutton.layer.cornerRadius = 2.0
        sessionStatusVutton.titleLabel?.font = sessionButtonFont
    }
    func setSessionUPUI(sessionDetailType: SessionStatusType){
        if session != nil, session.seshData != nil, session.seshData!.count > 0 {
        } else {
            return
        }
        userID = session.userId!
        let seshType = session.seshType!
        switch seshType {
        case SessionType.SHMOKE.rawValue:
            seshTypeString =  SHMOKE
        case SessionType.DROP.rawValue:
            seshTypeString =  DROP
        case SessionType.SMO.rawValue:
            seshTypeString = SMO
        case SessionType.MATCH.rawValue:
            seshTypeString = MATCH
        default:
            break
        }
        self.seshActionType = sessionDetailType
        switch sessionDetailType {
        case .acceptSession:
            crossButton.isHidden = true
            noThanksButton.contentEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 40)
            sessionStatusVutton.isHidden = true
            noThanksButton.isHidden = false
            viewSessionButton.isHidden = false
            self.seshStatusLabel.text = "\(seshTypeString) SESH"
            self.setUPsessionIDText(secondText: "HAS SENT NEW", third: "")
        case .approvedSession:
            crossButton.isHidden = false
            noThanksButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)
            sessionStatusVutton.isHidden = false
            noThanksButton.isHidden = true
            viewSessionButton.isHidden = true
            self.sessionStatusVutton.setTitle("SESH DETAILS", for: .normal)
            self.seshStatusLabel.text = "APPROVED"
            self.setUPsessionIDText(secondText: seshTypeString, third: "SESH")
            
        case .cancelled:
            noThanksButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10)
            crossButton.isHidden = true
            sessionStatusVutton.isHidden = false
            noThanksButton.isHidden = true
            viewSessionButton.isHidden = true
            self.seshStatusLabel.text = "CANCELLED"
            self.setUPsessionIDText(secondText: seshTypeString, third: "SESH")
            self.sessionStatusVutton.setTitle("GO BACK", for: .normal)
        case .none:
            break
        }
        
    }
    func viewSeshUI(){
        crossButton.isHidden = true
        sessionStatusVutton.backgroundColor = UIColor.themeYellowColor
        sessionStatusVutton.setTitleColor(UIColor.themeNavBarColor, for: .normal)
    }
    
    func setUPsessionIDText(secondText: String, third: String) {
        let secondString = " " +  secondText//"HAS SENT NEW"
        let firstString = "9080fish"
        let thirdString = " " + third
        let firstAttributtedString = NSMutableAttributedString(string: firstString)
        firstAttributtedString.font(Fonts.mavenProRegular.getFont(13)).underline().color(UIColor.white)
        
        let thirdAttributtedString = NSMutableAttributedString(string: thirdString)
        thirdAttributtedString.font(Fonts.mavenProRegular.getFont(13)).color(UIColor.white)
        
        
        let secondAttributtedString = NSMutableAttributedString(string: secondString)
        secondAttributtedString.font(Fonts.mavenProBold.getFont(13)).color(UIColor.white)
        
        self.seshTypeLabel.attributedText = firstAttributtedString + secondAttributtedString + thirdAttributtedString
    }
    @IBAction func sessionSytatusButtonAction(_ sender: Any) {
        if seshActionType == .approvedSession {
            self.delegate?.seshDetailsButtonClick(session: session)
        } else if seshActionType == .cancelled {
            self.delegate?.crossButtonClicked()
        }
        
    }
    @IBAction func viewSessionButtonAction(_ sender: Any) {
        self.delegate?.viewSessionClicked(session: session)
    }
    @IBAction func noThankdButtonAction(_ sender: Any) {
        self.delegate?.crossButtonClicked()
    }
    @IBAction func crossButtonAction(_ sender: Any) {
         self.delegate?.crossButtonClicked()
    }
    
}
