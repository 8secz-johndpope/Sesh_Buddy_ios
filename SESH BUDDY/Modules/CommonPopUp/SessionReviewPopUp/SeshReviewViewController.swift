//
//  SeshReviewViewController.swift
//  SESH BUDDY
//
//  Created by test on 17/11/18.
//  Copyright © 2018 Baljeet Kaur. All rights reserved.
//

protocol SeshReviewProtocols {
    func saveReviewButtonClicked(with: Session)
}

import UIKit

class SeshReviewViewController: UIViewController {

    
    @IBOutlet weak var seshReviewHeaderLabel: UILabel!
    @IBOutlet weak var seshIdLabel: UILabel!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var heightConstraintReviewTableView: NSLayoutConstraint!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var backgroundImsgeView: UIImageView!
    @IBOutlet weak var sessionButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var popUPView: UIView!
    
    @IBOutlet weak var bottomSepratorView: UIView!
    var delegate: SeshReviewProtocols?
    let buddyInfoTableViewCell = "BuddyInfoTableViewCell"
    let margin = 100
    var session: Session!
    var seshBuddiesArray: [SeshBuddies] = []
    var characterLimit = 100
    let tagOfPlaceholderLabel = 200
    let kQualityBaseTag = 7777777
    let kQuantityBaseTag = 33333
    let kRollsBaseTag = 88888
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        setUPUI()
    }
    func setUPUI(){
        let boldFont = Fonts.mavenProBold.getFont(16)
        self.seshReviewHeaderLabel.text = "SESH REVIEW"
        self.seshReviewHeaderLabel.font = boldFont
        self.bottomSepratorView.backgroundColor = UIColor.themeYellowColor
        self.popUPView.layer.borderColor = UIColor.themeYellowColor.cgColor
        self.popUPView.layer.borderWidth = 1
        self.popUPView.backgroundColor = UIColor.themeNavBarColor
        sessionButton.layer.cornerRadius = 2.0
        sessionButton.titleLabel?.font = Fonts.mavenProMedium.getFont(16)
        sessionButton.backgroundColor = UIColor.themeYellowColor
        sessionButton.setTitleColor(UIColor.themeNavBarColor, for: .normal)
        sessionButton.setTitle("SAVE REVIEW", for: .normal)
        self.setUPsessionIDText(secondText: "SHMOK", third: "SESH ENDED")
        crossButton.isHidden = true
    }
    func getGetBaseTagFrom(tag: Int) -> Int {
        if (tag - kQualityBaseTag) >= 0 && (tag - kQualityBaseTag) <= seshBuddiesArray.count {
            return kQualityBaseTag
        } else if (tag - kQuantityBaseTag) >= 0 && (tag - kQuantityBaseTag) <= seshBuddiesArray.count {
            return kQuantityBaseTag
        } else {
            return kRollsBaseTag
        }
        
       
    }
    func registerNib(){
        reviewTableView.registerCellFrom(buddyInfoTableViewCell)
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.reloadData()
    }
    @IBAction func crossButtonAction(_ sender: Any) {
    }
    
    func reloadView() {
        
        
        for info in session.seshBuddies {
            info.qualityRating = NSNumber(value: 0.0)
            info.quantityRating = NSNumber(value: 0.0)
            info.rollsRating = NSNumber(value: 0.0)
            info.comment = ""
            seshBuddiesArray.append(info)
        }
        
        
        self.reviewTableView.reloadData()
        self.reviewTableView.layoutIfNeeded()
        if reviewTableView.contentSize.height > screenHeight - CGFloat((2 * margin)) {
            self.heightConstraintReviewTableView.constant = screenHeight - CGFloat((2 * margin))
        } else {
            self.heightConstraintReviewTableView.constant = reviewTableView.contentSize.height
        }
        
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
        
        self.seshIdLabel.attributedText = firstAttributtedString + secondAttributtedString + thirdAttributtedString
    }
    @IBAction func sessionButtonAction(_ sender: Any) {
        self.delegate?.saveReviewButtonClicked(with: session)
    }
    
}
extension SeshReviewViewController: UITableViewDelegate {
    
}
extension SeshReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if session != nil {
            return session.seshBuddies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: buddyInfoTableViewCell) as? BuddyInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.bottomConstraintOfBgView.constant = 1.0
        cell.buddyCommentTextView.delegate = self
        cell.buddyCommentTextView.tag = indexPath.row
        cell.qualityRatingView.delegate = self
        cell.rollsRatingView.delegate = self
        cell.quantityRatingView.delegate = self
        cell.qualityRatingView.tag = kQualityBaseTag + indexPath.row
        cell.quantityRatingView.tag = kQuantityBaseTag + indexPath.row
        cell.rollsRatingView.tag = kRollsBaseTag + indexPath.row
        cell.setUPStarRating(isEditable: true)
        if seshBuddiesArray.count > indexPath.row {
            cell.setUPDetails(from: seshBuddiesArray[indexPath.row])
            let aboutMe = seshBuddiesArray[indexPath.row].comment
            if aboutMe != "" {
                cell.placeHolderLabel.isHidden = true
                cell.characterLimitLabel.text = "\(characterLimit-aboutMe!.count)/\(characterLimit)"
            }else {
                cell.characterLimitLabel.text = "Max 100 characters"
            }
        }
        
        cell.selectionStyle = .none
        cell.placeHolderLabel.tag = tagOfPlaceholderLabel
        return cell
    }
}
extension SeshReviewViewController: UITextViewDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
            let thisIndexPath = IndexPath(row: textView.tag, section: 0)
            let cell = self.reviewTableView.cellForRow(at: thisIndexPath) as? BuddyInfoTableViewCell
            
            let currentText:NSString = textView.text as NSString
            let updatedText = currentText.replacingCharacters(in: range, with: text)
            
            let startHeight = textView.frame.size.height
            let calcHeight = textView.sizeThatFits(textView.frame.size).height  //iOS 8+ only
            
            if startHeight != calcHeight {
                
                UIView.setAnimationsEnabled(false) // Disable animations
                self.reviewTableView.beginUpdates()
                self.reviewTableView.endUpdates()
                UIView.setAnimationsEnabled(true)
                reviewTableView?.scrollToRow(at: thisIndexPath,
                                              at: .bottom,
                                              animated: false)
            }
            let aboutMe = updatedText
           self.seshBuddiesArray[textView.tag].comment = aboutMe
            let superViewOfTextView = textView.superview
            let placeHolderLabel = superViewOfTextView?.viewWithTag(tagOfPlaceholderLabel)
            if aboutMe.count == 0 {
                cell?.characterLimitLabel.text = "\(characterLimit)"
                if placeHolderLabel != nil {
                    placeHolderLabel!.isHidden = false
                }
            } else {
                if aboutMe.count <= characterLimit {
                    cell?.characterLimitLabel.text = "\(characterLimit-aboutMe.count)/\(characterLimit)"
                    if placeHolderLabel != nil {
                        placeHolderLabel!.isHidden = true
                    }
                }
                else {
                    return false
                }
            }
        
        
        return true
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
            let thisIndexPath = IndexPath(row: textView.tag, section: 0)
            let cell = self.reviewTableView.cellForRow(at: thisIndexPath) as? TextViewTableViewCell
            cell?.placeHolderLAbel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let aboutMe = textView.text
        
        let superViewOfTextView = textView.superview
        let placeHolderLabel = superViewOfTextView?.viewWithTag(tagOfPlaceholderLabel)
        if aboutMe != nil, aboutMe!.count == 0 {
            
            if placeHolderLabel != nil {
                placeHolderLabel!.isHidden = false
            }
        } else {
            if placeHolderLabel != nil {
                placeHolderLabel!.isHidden = true
            }
        }
        self.seshBuddiesArray[textView.tag].comment = aboutMe
        self.reviewTableView.reloadData()
    }
    
    func updateHeightOfTextView(textview: UITextView) {
            let indexPath = IndexPath(row: textview.tag, section: 0)
            let startHeight = textview.frame.size.height
            let calcHeight = textview.sizeThatFits(textview.frame.size).height  //iOS 8+ only
            
            if startHeight != calcHeight {
                
            }
        
    }
    func textViewDidChange(_ textView: UITextView) {
        self.updateHeightOfTextView(textview: textView)
    }
}
extension SeshReviewViewController: FloatRatingViewDelegate {
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        let baseTag = self.getGetBaseTagFrom(tag: ratingView.tag)
        let buddiesArray = self.seshBuddiesArray
        if  baseTag == kQuantityBaseTag {
            buddiesArray[ratingView.tag - baseTag].quantityRating = NSNumber(value: rating)
            
        } else if  baseTag == kQualityBaseTag {
            buddiesArray[ratingView.tag - baseTag].qualityRating = NSNumber(value: rating)
        } else {
            buddiesArray[ratingView.tag - baseTag].rollsRating = NSNumber(value: rating)
        }
        self.seshBuddiesArray = buddiesArray
        self.reviewTableView.reloadData()
    }
    
    
}
