//
//  MovieList.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/8/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import Foundation
import Alamofire

class MovieList {
    
    //MARK: - Fild
    fileprivate var _title: String!
    fileprivate var _year:String!
    fileprivate var _rated:String!
    fileprivate var _released:String!
    fileprivate var _runtime:String!
    fileprivate var _genre:String!
    fileprivate var _director:String!
    fileprivate var _writer:String!
    fileprivate var _actors:String!
    fileprivate var _plot:String!
    fileprivate var _language:String!
    fileprivate var _country:String!
    fileprivate var _awards:String!
    fileprivate var _poster:String!
    fileprivate var _metascore:String!
    fileprivate var _imdbRating:String!
    fileprivate var _imdbVotes:String!
    fileprivate var _imdbID:String!
    fileprivate var _type:String!
    fileprivate var _movieListUrl:String!
    fileprivate var _numberMovie:Int!
    fileprivate var _favorite:Bool!
    fileprivate var _view:Bool!
    fileprivate var _resolution:String!
    
    //MARK: - Property
    var title:String {
        get {
            if _title == nil{
                return ""
            }
            return _title
        }
    }
    var year:String{
        get {
            if _year == nil {
                return ""
            }
            return _year
        }
    }
    var rated:String {
        get {
            if _rated == nil {
                return ""
            }
            return _rated
        }
    }
    var released:String {
        get {
            if _released == nil{
                return ""
            }
            return _released
        }
    }
    var runtime:String {
        get {
            if _runtime == nil{
                return ""
            }
            return _runtime
        }
    }
    var genre:String {
        get {
            if _genre == nil {
                return ""
            }
            return _genre
        }
    }
    var director:String {
        get {
            if _director == nil {
                return ""
            }
            return _director
        }
    }
    var writer:String {
        get {
            if _writer == nil {
                return ""
            }
            return _writer
        }
    }
    var actors:String {
        get {
            if _actors == nil {
                return ""
            }
            return _actors
        }
    }
    var plot:String {
        get {
            if _plot == nil {
                return ""
            }
            return _plot
        }
    }
    var language:String {
        get {
            if _language == nil {
                return ""
            }
            return _language
        }
    }
    var country:String {
        get {
            if _country == nil {
                return ""
            }
            return _country
        }
    }
    var awards:String {
        get {
            if _awards == nil {
                return ""
            }
            return _awards
        }
    }
    var poster:String {
        get {
            if _poster == nil {
                return ""
            }
            return _poster
        }
    }
    var metascore:String {
        get {
            if _metascore == nil{
                return ""
            }
            return _metascore
        }
    }
    var imdbRating:String{
        get {
            if _imdbRating == nil {
                return ""
            }
            return _imdbRating
        }
    }
    var imdbVotes:String {
        get {
            if _imdbVotes == nil {
                return ""
            }
            return _imdbVotes
        }
    }
    var imdbID: String {
        get {
            if _imdbID == nil {
                return " "
            }
            return _imdbID
        }
    }
    var type:String {
        get {
            if _type == nil {
                return ""
            }
            return _type
        }
    }
    var numberMovie:Int {
        get{
            if _numberMovie == nil {
                return 0
            }
            return _numberMovie
        }
    }
    var favorite:Bool {
        
        get {
            if _favorite == nil {
                return false
            }
            return true
        }
    }
    var view:Bool {
        
        get {
            if _view == nil {
                return false
            }
            return true
        }
    }
    var resolution:String {
        
        get {
            if _resolution == nil {
                return "NoResolution"
            }
            return _resolution
        }
        
    }
    
    //MARK: - init
    // intializ method full
    init(dictionaryDetails:NSDictionary) {
        
        _actors = dictionaryDetails["Actors"] as? String
        _awards = dictionaryDetails["Awards"] as? String
        _country = dictionaryDetails["Country"] as? String
        _director = dictionaryDetails["Director"] as? String
        _genre = dictionaryDetails["Genre"] as? String
        _language = dictionaryDetails["Language"] as? String
        _metascore = dictionaryDetails["Metascore"] as? String
        _plot = dictionaryDetails["Plot"] as? String
        _poster = dictionaryDetails["Poster"] as? String
        _rated = dictionaryDetails["Rated"] as? String
        _released = dictionaryDetails["Released"] as? String
        _runtime = dictionaryDetails["Runtime"] as? String
        _title = dictionaryDetails["Title"] as? String
        _type = dictionaryDetails ["Type"] as? String
        _writer = dictionaryDetails["Writer"] as? String
        _year = dictionaryDetails ["Year"] as? String
        _imdbRating = dictionaryDetails ["imdbRating"] as? String
        _imdbVotes = dictionaryDetails["imdbVotes"] as? String
        _favorite = dictionaryDetails["favorite"] as? Bool
        _view = dictionaryDetails["view"] as? Bool
        _resolution = dictionaryDetails["resolution"] as? String
        
    }
    
    // intializ method title
    init(dictionary: NSDictionary) {
        
        _title = dictionary["Title"] as? String
        _type = dictionary["Type"] as? String
        _year = dictionary["Year"] as? String
        _poster = dictionary ["Poster"] as? String
        _imdbID = dictionary ["imdbID"] as? String
        
    }
}
