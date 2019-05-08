//
//  ShowFullPosterViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/12/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import UIKit

class ShowFullPosterViewController: UIViewController,UIImagePickerControllerDelegate {

    // MARK: - Outlet
    @IBOutlet weak var showFullPosterBtn: UIButton!
    
    // MARK: - let & var
    var imagePicker : UIImagePickerController!
    
    var urlImage : String {
        
        get {
            return UserDefaults.standard.object(forKey: "urlImage") as! String
        }
    }
    
    var modePosterButton : Bool {
        
        get {
            return UserDefaults.standard.object(forKey: "modePosterButton") as! Bool
        }
        
    }
    
    // MARK: - override func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        // imagePicker.delegate = self
        
        super.viewDidLoad()
        
        // Condition mode show poster
        if modeShowPosterImage == true {
            
            
            if let urlPoster = URL(string: urlImage) {
                
                if let dataImage = try? Data(contentsOf: urlPoster) {
                     
                    showFullPosterBtn.setBackgroundImage(UIImage(data: dataImage), for: UIControlState.normal)
                }
            }
            
        } else {
           
            showFullPosterBtn.setBackgroundImage(movieSelectRow.getMovieListImg(), for: UIControlState.normal)
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action func
    @IBAction func showInformation(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
