//
//  Alert.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/10/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import Foundation
import UIKit

enum Actions {
    
    case Ok
    case Cancel
    case Start
    case Error
}

func alertMe(title: String, message: String, value: Int) -> UIAlertController {
    
    let alert:UIAlertController = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: .alert)
    
    if value == 100 {
        
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (a: UIAlertAction) ->Void in
            return
        }
        alert.addAction(actionOK)
        
    } else if value == 101 {
        
        let actionStart:UIAlertAction = UIAlertAction(title: "Start", style: UIAlertActionStyle.default) { (a: UIAlertAction) ->Void in
            
            //   _ = BackUpAndRestoreVC()
            // backup.restoreBackUpCsvFile()
            
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        
        alert.addAction(actionStart)
        alert.addAction(actionCancel)
        
    } else if value == 102 {
        
        let actionOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (a: UIAlertAction) -> Void in
            
            //            let addVC = AddVC()
            //            _ = addVC.backToSearch()
            
        }
        
        alert.addAction(actionOK)
    }
    
    return alert
}

