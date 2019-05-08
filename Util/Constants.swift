//
//  Constants.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/7/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: var & let
let URL_SEARCHMOVIE_BASE = "http://www.omdbapi.com/?s="
let URL_SEARCHMOVIE_ID   = "http://www.omdbapi.com/?i="
let URL_SEARCHMOVIE_PATH = "&plot=full&r=json"
//let API_KEY = "&apikey=85d859be"
let API_KEY = "&apikey=458716e"
var idSelected : String!
var modeShowPosterImage = Bool()
var movieSelectRow : MyMoviesList!

extension UIImageView {
    
    func addBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
    }
}

// ImageViewCornerRadius
extension UIImageView {
    
    func imageCornerRadius() {
        
        _ = layer.cornerRadius = 8
        _ = clipsToBounds = true
        
    }
}

// TextFiledCornerRadius
extension UITextField {
    
    func customTextFiled(switchFlag:Bool) {
        
        if switchFlag == true {
            
            _ = layer.cornerRadius = 6
            _ = clipsToBounds = true
            backgroundColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 0.2)
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0).cgColor
            self.isUserInteractionEnabled = true
        } else {
            
            self.backgroundColor = UIColor.clear
            self.layer.borderWidth = 0.0
            self.layer.borderColor = UIColor.clear.cgColor
            self.isUserInteractionEnabled = false
        }
        
        
    }
}

// ButtonCornerRadius
extension UIButton {
    
    func buttonCornerRadius() {
        
        _ =  layer.cornerRadius = 8
        _ = clipsToBounds = true
        
    }
    
    func customButton(switchFlag:Bool) {
        
        if switchFlag == true {
            
            self.backgroundColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 0.2)
            self.setTitleColor(UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0), for: UIControlState.normal)
            self.layer.cornerRadius = 6
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0).cgColor
            self.isUserInteractionEnabled = true
            
        } else {
            
            self.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.backgroundColor = UIColor.clear
            self.layer.borderWidth = 0.0
            self.layer.borderColor = UIColor.clear.cgColor
            self.isUserInteractionEnabled = false
            
        }
    }
}

extension UITextView {
    
    func customTextView(switchFlag:Bool) {
        
        if switchFlag == true {
            backgroundColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 0.2)
            self.layer.cornerRadius = 6
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0).cgColor
            self.isUserInteractionEnabled = true
            
        } else {
            
            self.backgroundColor = UIColor.clear
            self.layer.borderWidth = 0.0
            self.layer.borderColor = UIColor.clear.cgColor
            self.isUserInteractionEnabled = false
        }
        
    }
}

extension UISearchBar {
    
    func changeColorTextSearchBar(searchBar:UISearchBar) {
        
        let textFieldSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldSearchBar?.textColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
    }
}

extension UINavigationController {
    
    func setImageBackgroundNavgtionBar() {
        
        let imageBackgroundNavgtion = UIImage(named: "background_Image_Navgtion_Black")
        
        //let navigationController = UINavigationController()
        
        self.navigationBar.setBackgroundImage(imageBackgroundNavgtion, for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
    }
    
}

extension MyMoviesList {
    
    // MARK: - NSManaged var
    @NSManaged var actors: String?
    @NSManaged var awards: String?
    @NSManaged var country: String?
    @NSManaged var director: String?
    @NSManaged var genre: String?
    @NSManaged var imdbRating: String?
    @NSManaged var imdbVotes: String?
    @NSManaged var imdbID: String?
    @NSManaged var language: String?
    @NSManaged var metascore: String?
    @NSManaged var numberMovie: NSNumber?
    @NSManaged var plot: String?
    @NSManaged var poster: String?
    @NSManaged var rated: String?
    @NSManaged var released: String?
    @NSManaged var runtime: String?
    @NSManaged var title: String?
    @NSManaged var type: String?
    @NSManaged var writer: String?
    @NSManaged var year: String?
    @NSManaged var favorite: Bool
    @NSManaged var view: Bool
    @NSManaged var resolution: String
}
