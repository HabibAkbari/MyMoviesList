//
//  SearchToIMDBTableViewCell.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/7/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import UIKit

class SearchToIMDBTableViewCell: UITableViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    // MARK: - var
    var movieList:MovieList!

    // MARK: - Func
    func configureCell(_ movielist:MovieList) {
        
        self.movieList = movielist
        
        if let url = URL(string: "\(movieList.poster)") {
           
            if let data = try? Data(contentsOf: url) {
                
                posterImg.image = UIImage(data: data)
                
            }
            
        }
        
        posterImg.imageCornerRadius()
        titleLbl.text = "\(movieList.title) (\(movieList.year))"
        typeLbl.text  = movieList.type
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
