//
//  DocumentDirectory.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/10/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import Foundation

// create directory
func createDirectory() {
    
    let documentDirectoryPath = editDirectory()
    let imagesDirectoryPath = documentDirectoryPath.appending("/MyMovieListImages")
    let fileManager = FileManager.default
    if !fileManager.fileExists(atPath: imagesDirectoryPath) {
        
        do {
            try fileManager.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch {
            return
        }
    }
    
}

// get directory
func getDirectoryPath() -> String {
    
    let documentDirectory = editDirectory()
    let imagesDirectoryPath = documentDirectory.appending("/MyMovieListImages")
    return imagesDirectoryPath
}

// edit directory
func editDirectory () -> String {
    
    let pathDirectoryMain = NSHomeDirectory()
    let combinePath = "\(pathDirectoryMain)/Documents"
    
    return combinePath
    
}
