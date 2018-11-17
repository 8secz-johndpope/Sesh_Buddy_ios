//
//  SelectImage.swift
//  ClinicWorldDoctor
//
//  Created by CL-macmini53 on 3/15/16.
//  Copyright © 2016 Click-Labs. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

@objc protocol SavedImageDelegate {
    func imageSelectedSuccesfully(_ filePath:String , image: UIImage)
   @objc optional func gallerySelected( selected: Bool)

}

class SelectImage: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    static let sharedInstance = SelectImage()
    
    var filePath = String()
    
    var picker = UIImagePickerController()
    
    weak var delegate:SavedImageDelegate!
    
    func selectImage(_ viewController:UIViewController, folderPath:String, fileName:String) {
        
        filePath = folderPath + "/\(fileName)"
        
        self.picker.delegate = self
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take a new Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
             let persmission = self.checkPermissionVideo()
            if persmission == AVAuthorizationStatus.authorized {
                    self.openCamera(viewController)
            } else if  persmission == AVAuthorizationStatus.notDetermined {
                
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
                    bool in
                    if bool {
                        self.openCamera(viewController)
                    } else {
                        UIAlertController.presentAlert(title: nil, message: "Camera permission denied", style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
                    }
                })
                
            } else {
                
                UIAlertController.presentAlert(title: nil, message: "Camera permission denied", style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
            }
            
            
        })
        
        let photoLibraryAction = UIAlertAction(title: "Choose from existing".localized, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            /*
            let pushToCustomLibraryController = viewController.storyboard?.instantiateViewController(withIdentifier: "CustomImageLibraryViewController") as? CustomImageLibraryViewController
            
            viewController.present(pushToCustomLibraryController!, animated: true, completion: nil)
            */
            self.picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            viewController.present(self.picker, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: AppStrings.Cancel.localized, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    
    func openCamera(_ viewController: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            self.picker.sourceType = UIImagePickerControllerSourceType.camera
            viewController.present(self.picker, animated: true, completion: nil)
            
            //                self.viewController.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
            //                })
        } else{
            UIAlertController.presentAlert(title: nil, message: "Device has no Camera", style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
        }
    }
    
    func selectImageWithMultipleMode(_ viewController:UIViewController, folderPath:String, fileName:String) {
        
        
        filePath = folderPath + "/\(fileName)"
        
        self.picker.delegate = self
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take a new Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let persmission = self.checkPermissionVideo()
            if persmission == AVAuthorizationStatus.authorized {
                self.openCamera(viewController)
            } else if  persmission == AVAuthorizationStatus.notDetermined {
                
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
                    bool in
                    if bool {
                        self.openCamera(viewController)
                    } else {
                        UIAlertController.presentAlert(title: nil, message: "Camera denied permission", style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
                    }
                })
                
            } else {
                
                UIAlertController.presentAlert(title: nil, message: "Camera denied permission".localized, style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
            }
            
        })
        
        let photoLibraryAction = UIAlertAction(title: "Choose fro existing", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            /*
             let pushToCustomLibraryController = viewController.storyboard?.instantiateViewController(withIdentifier: "CustomImageLibraryViewController") as? CustomImageLibraryViewController
             
             viewController.present(pushToCustomLibraryController!, animated: true, completion: nil)
             */
            self.performStatusBasedGalleryAction(viewController)
            
        })
        
        let cancelAction = UIAlertAction(title: AppStrings.Cancel.localized, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
  
    @discardableResult
    func checkCamera(_ viewController : UIViewController) -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case AVAuthorizationStatus.authorized: return true
        case AVAuthorizationStatus.denied: alertToEncourageCameraAccessInitially(viewController)
        return false
        default: alertToEncourageCameraAccessInitially(viewController)
        return false
        }
        
    }
    
    func alertToEncourageCameraAccessInitially(_ viewController : UIViewController) {
        let alert = UIAlertController(title: "IMPORTANT", message: "Camera access required", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
        }))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    func alertPromptToAllowCameraAccessViaSetting(_ viewController : UIViewController) {
        
        let alert = UIAlertController(title: "IMPORTANT", message: "Please allow camera access", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel) { alert in
            if AVCaptureDevice.devices(for: AVMediaType.video).count > 0 {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                    DispatchQueue.main.async {
                        self.checkCamera(viewController)
                        
                    }
                    
                }
            }
        })
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func checkPermissionVideo() -> AVAuthorizationStatus {
        
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        if(status == AVAuthorizationStatus.authorized) {
            return AVAuthorizationStatus.authorized
        } else if(status == AVAuthorizationStatus.denied){
            return AVAuthorizationStatus.denied
        } else if(status == AVAuthorizationStatus.restricted){
            return AVAuthorizationStatus.restricted
        } else {
            return AVAuthorizationStatus.notDetermined
        }
    }
    
    // MARK: Image Picker Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if UIImageJPEGRepresentation(pickedImage, 1.0)!.count > 3*1024 {
                try? UIImageJPEGRepresentation(pickedImage, 0.1)?.write(to: Foundation.URL(fileURLWithPath: String(filePath as NSString)), options: [.atomic])
            }
            else if UIImageJPEGRepresentation(pickedImage, 1.0)!.count > 2*1024 {
                try? UIImageJPEGRepresentation(pickedImage, 0.5)?.write(to: Foundation.URL(fileURLWithPath: String(filePath as NSString)), options: [.atomic])
            }
            else {
                try? UIImageJPEGRepresentation(pickedImage, 0.75)?.write(to: Foundation.URL(fileURLWithPath: String(filePath as NSString)), options: [.atomic])
            }
            
            delegate.imageSelectedSuccesfully(filePath, image: pickedImage.normalizedImage())
            
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func performStatusBasedGalleryAction(_ viewController : UIViewController) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            self.delegate.gallerySelected!(selected: true)
        }
            
        else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
             UIAlertController.presentAlert(title: nil, message: "Gallery denied permission", style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
            
        }
            
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.delegate.gallerySelected!(selected: true)
                }
                    
                else {
                    self.performStatusBasedGalleryAction(viewController)
                }
            })
        }
            
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
            UIAlertController.presentAlert(title: nil, message: "Gallery denied permission", style: UIAlertControllerStyle.alert).action(title: AppStrings.Ok.localized, style: UIAlertActionStyle.default, handler: nil)
        }
    }
    
}












