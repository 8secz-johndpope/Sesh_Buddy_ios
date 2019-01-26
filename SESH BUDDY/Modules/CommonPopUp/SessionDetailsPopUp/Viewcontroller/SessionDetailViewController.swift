//
//  SessionDetailViewController.swift
//  SESH BUDDY
//
//  Created by test on 17/11/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

protocol SessionDetailsViewProtocols {
    func seshUPButtonClicked(session: Session, type: SessionStatusDetailType)
    func crossSeshUPButtonClicked()
    func cancelSeshButtonClicked(session: Session)
}
enum SessionStatusType{
    case acceptSession
    case approvedSession
    case cancelled
    case none
}
enum SessionStatusDetailType{
    case addSession
    case acceptSession
    case viewSession
    case cancelSession
    case none
}
enum SeshDetailsSestion: Int {
    case seshDetails
    case buddies
    case count
}
import UIKit

class SessionDetailViewController: UIViewController {
    @IBOutlet weak var tableViewHeightConstant: NSLayoutConstraint!
    
    @IBOutlet weak var seshUPButton: UIButton!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bttomView: UIView!
    @IBOutlet weak var sessionDetailTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bottomSepratorView: UIView!
    @IBOutlet weak var seshTypeLabel: UILabel!
    @IBOutlet weak var sessionDetailsHeaderLabel: UILabel!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    var delegate: SessionDetailsViewProtocols?
    var sessionDetailType: SessionStatusDetailType!
    let sessionDetailsTableViewCell = "SessionDetailsTableViewCell"
    var sessionsDetails = [SeshData]()
    var session: Session!
    var buddiesText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        setUPUI()
    }
   
    
    func setUPUI(){
        if session != nil, session.seshData != nil, session.seshData!.count > 0 {
            sessionsDetails = session.seshData!
        } else {
             return
        }
        let budyName = (session.seshBuddies.map { $0.buddyName!}).joined(separator: ",")
  //
        self.buddiesText = budyName
        let seshid = session.userId!
        let seshType = session.seshType!
        var seshTypeString = ""
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
        
        let seshIDString = NSMutableAttributedString(string: seshid).underline().color(UIColor.white).font(Fonts.mavenProRegular.getFont(13))
        self.seshTypeLabel.attributedText = seshIDString
        let boldFont = Fonts.mavenProBold.getFont(16)
        self.sessionDetailsHeaderLabel.font = boldFont
        self.sessionDetailsHeaderLabel.text = seshTypeString + " SESH DETAILS"
        popUpView.backgroundColor = UIColor.themeNavBarColor
        popUpView.layer.borderColor = UIColor.themeYellowColor.cgColor
        popUpView.layer.borderWidth = 1.0
        self.seshUPButton.layer.cornerRadius = 2.0
        
        self.bottomLabel.font = Fonts.mavenProRegular.getFont(13)
        self.seshUPButton.titleLabel?.font = boldFont
        self.seshUPButton.backgroundColor = UIColor.buttonColor
        seshUPButton.setTitleColor(UIColor.white, for: .normal)
        if sessionDetailType == .cancelSession {
            self.crossButton.isHidden = false
            seshUPButton.backgroundColor = UIColor.themeYellowColor
            seshUPButton.setTitleColor(UIColor.themeNavBarColor, for: .normal)
            seshUPButton.setTitle("CANCEL SESSION", for: .normal)
            self.bottomLabel.text = "PLANS CHANGED? CLICK BUTTON TO CANCEL SESH"
        } else {
            seshUPButton.setTitle("SESH UP", for: .normal)
            self.bottomLabel.text = "TO CONFIRM \(seshTypeString), CLICK SESH UP"
        }
    }
    func registerNib() {
        sessionDetailTableView.registerCellFrom(sessionDetailsTableViewCell)
        sessionDetailTableView.delegate = self
        sessionDetailTableView.dataSource = self
        
    }
    func reloadView() {
        if sessionDetailType == .viewSession {
            self.bttomView.isHidden  = true
            bottomViewHeightConstraint.constant = 0
        } else if sessionDetailType == .cancelSession {
            self.bttomView.isHidden  = false
            bottomViewHeightConstraint.constant = 100
        } else {
            self.bttomView.isHidden  = false
            bottomViewHeightConstraint.constant = 100
        }
        self.sessionDetailTableView.reloadData()
        self.sessionDetailTableView.layoutIfNeeded()
        self.tableViewHeightConstant.constant = sessionDetailTableView.contentSize.height
    }
    func setUPSessionDetailsOnly() {
        self.bttomView.isHidden = true
    }
    @IBAction func crossButtonAction(_ sender: Any) {
        self.delegate?.crossSeshUPButtonClicked()
    }
    @IBAction func seshUPButtonAction(_ sender: Any) {
        if sessionDetailType == .cancelSession {
            self.delegate?.cancelSeshButtonClicked(session: session)
        } else if sessionDetailType == .addSession {
             self.delegate?.seshUPButtonClicked(session: session, type: sessionDetailType)
        } else if sessionDetailType == .acceptSession {
            self.delegate?.seshUPButtonClicked(session: session, type: sessionDetailType)
        }
    }
}
extension SessionDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SeshDetailsSestion.count.rawValue
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SeshDetailsSestion.seshDetails.rawValue {
            return sessionsDetails.count
        } else if section == SeshDetailsSestion.buddies.rawValue {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sessionDetailsTableViewCell) as? SessionDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == SeshDetailsSestion.seshDetails.rawValue {
            if self.sessionsDetails.count > indexPath.row {
                let sessionInfo = self.sessionsDetails[indexPath.row]
                cell.setUPData(info: sessionInfo)
            }
        } else {
            cell.leftLAbel.text = "BUDDIES:"
            cell.rightLAbel.text = buddiesText
        }
        
        tableView.layoutIfNeeded()
        self.tableViewHeightConstant.constant = tableView.contentSize.height
        return cell
    }
    
}
extension SessionDetailViewController: UITableViewDelegate {
    
}
