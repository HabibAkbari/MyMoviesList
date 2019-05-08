//
//  LoadListMoviesTableViewCell.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/14/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import UIKit

class LoadListMoviesTableViewCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var actorsLbl: UILabel!
    @IBOutlet weak var imdbRatingLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    //@IBOutlet weak var runtimeLbl:UILabel!
    @IBOutlet weak var languageLbl:UILabel!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var viewImg: UIImageView!
    
    // MARK: - Override Func
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImg.layer.shadowColor = UIColor.white.cgColor
        posterImg.layer.shadowOpacity = 1
        posterImg.layer.shadowOffset = CGSize.zero
        posterImg.layer.shadowRadius = 10
        posterImg.layer.shadowPath = UIBezierPath(rect: posterImg.bounds).cgPath
        posterImg.layer.shouldRasterize = true
        
    }
    
    // MARK: - Func
    // Configu Cell
    func configureCell(_ myMoviesList: MyMoviesList) {
        
        titleLbl.text = "\(myMoviesList.title!) (\(myMoviesList.year!))"
        actorsLbl.text = myMoviesList.actors
        imdbRatingLbl.text = myMoviesList.imdbRating
        numberLbl.text = "\(myMoviesList.numberMovie!)"
        //runtimeLbl.text = myMoviesList.runtime
        languageLbl.text = myMoviesList.language
        posterImg.image = myMoviesList.getMovieListImg()
        posterImg.imageCornerRadius()
        
        if myMoviesList.favorite == true {
            heart.image = UIImage(named: "heartRead.png")
        } else {
            heart.image = UIImage(named: "heartLightGray.png")
        }
        
        if myMoviesList.view == true {
            viewImg.image = UIImage(named: "viewYallow.png")
        } else {
            viewImg.image = UIImage(named: "viewLightGray.png")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }

}
