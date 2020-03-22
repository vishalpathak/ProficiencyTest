//
//  UIAlertHelper.swift
//  ProficiencyTest
//
//  Created by VishalP on 21/03/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit
class UIAlertHelper {
    
    // Create alert view on the basis of controller and message
    class func presentAlertOnController(_ controller:UIViewController, title:String?, message:String?) {
        
        let alertController = UIAlertController(title: title ?? "", message:
            message ?? "", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: AlertMessages.ButtonTitle, style: UIAlertAction.Style.default,handler: nil))
        controller.present(alertController, animated: true, completion: nil)
        
    }
}
