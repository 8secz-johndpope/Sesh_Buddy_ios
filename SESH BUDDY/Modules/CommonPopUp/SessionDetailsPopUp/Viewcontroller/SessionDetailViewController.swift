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
}
enum SessionStatusType{
    case acceptSession
    case approvedSession
    case cancelled
    case none
}
enum SessionStatusDetailType{
    case addSession
    case viewSession
    case none
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
        self.bottomLabel.text = "TO CONFIRM \(seshTypeString), CLICK SESH UP"
        self.bottomLabel.font = Fonts.mavenProRegular.getFont(13)
        self.seshUPButton.titleLabel?.font = boldFont
        self.seshUPButton.backgroundColor = UIColor.buttonColor
        seshUPButton.setTitleColor(UIColor.white, for: .normal)
        seshUPButton.setTitle("SESH UP", for: .normal)
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
        self.delegate?.seshUPButtonClicked(session: session, type: sessionDetailType)
    } 
}
extension SessionDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  sessionsDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: sessionDetailsTableViewCell) as? SessionDetailsTableViewCell else {
            return UITableViewCell()
        }
        if self.sessionsDetails.count > indexPath.row {
            let sessionInfo = self.sessionsDetails[indexPath.row]
            cell.setUPData(info: sessionInfo)
        }
        tableView.layoutIfNeeded()
        self.tableViewHeightConstant.constant = tableView.contentSize.height
        return cell
    }
    
}
extension SessionDetailViewController: UITableViewDelegate {
    
}
