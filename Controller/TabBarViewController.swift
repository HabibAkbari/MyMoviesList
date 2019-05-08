//
//  TabBarViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/19/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
   
    override func viewDidLoad() {
        
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
        // change back ground tabBarview
        let imageBackground = UIImage(named: "backgroundImage_Tabbar_Black")
        //let img = UIImage(named: "background_button")
        let tabbar = self.tabBar
        //tabbar.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.0)
        tabbar.backgroundImage = imageBackground
        tabbar.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Func
    func backgroundTableView() {
        
        let backGroundImage = UIImage(named: "background_image_view.jpg")
        let imageView = UIImageView(image: backGroundImage)
        let tabbar = self.tabBar
        tabbar.backgroundImage = backGroundImage
        imageView.contentMode = .bottom
        tabbar.backgroundColor = .lightGray
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
