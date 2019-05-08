//
//  MyMoviesList.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/10/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MyMoviesList: NSManagedObject {
    
    // MARK: Func
    // copy image to path app
    func setMovieListImg(_ img:UIImage) {
        
        let data = UIImageJPEGRepresentation(img, 1.0)
        var path = URL(fileURLWithPath: "")
        
        // call createDirectory func
        createDirectory()

        path = URL(fileURLWithPath: "\(getDirectoryPath())/\(self.title!).jpg")
        try? FileManager.default.removeItem(at: path)
        try? data?.write(to: path)
        
    }

    // load image on patch app
    func getMovieListImg() -> UIImage {
        
        var path = URL(fileURLWithPath: "")
        path = URL(fileURLWithPath:"\(getDirectoryPath())/\(self.poster!)")
        
        let imageData = NSData(contentsOf: path)
        var getImage = UIImage()
        
        if imageData != nil {
            
            getImage = UIImage(data: imageData! as Data)!
            
        } else {
            
            getImage =  UIImage(named: "Mask-128.jpg")!
            
        }
        
        return getImage
        
    }
    
    
}
