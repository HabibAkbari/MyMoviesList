//
//  SearchToIMDBViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/7/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

extension UISearchBar {
   
    public var textField: UITextField? {

        return subviews.first?.subviews.compactMap { $0 as? UITextField}.first
        
    }
    
    private var activityIndicator: UIActivityIndicatorView? {
        
        return textField?.leftView?.subviews.compactMap{$0 as? UIActivityIndicatorView}.first
        
    }
    
    var isLoading : Bool {
        
        get {
            
            return activityIndicator != nil
            
        } set {
            
            if newValue {
                
                if activityIndicator == nil {
                    
                    let _activityIndicator = UIActivityIndicatorView(frame: CGRect(x: -5, y: -5, width: 20, height: 20))
                    _activityIndicator.color = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
                    _activityIndicator.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    _activityIndicator.startAnimating()
                    _activityIndicator.backgroundColor = UIColor.clear
                    
                    textField?.leftView?.addSubview(_activityIndicator)
                    _ = textField?.rightView?.frame.size ?? CGSize.zero
                    
                }
            } else {
                
                activityIndicator?.removeFromSuperview()
            }
            
        }
    }
    
}

class SearchToIMDBViewController: UIViewController,UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate, UITabBarDelegate {

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - var & let
    var inSearchMode = false
    var moviesSearchImdb = [MovieList]()
    var searchBarButtonItem: UIBarButtonItem!
    var resultSearchController = UISearchController()
    let searchBar = UISearchBar()
    
    
    // MARK: - override func
    override func viewDidLoad() {
        
        super.viewDidLoad()

        resultSearchController.searchBar.delegate = self
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        

        self.navigationController?.setImageBackgroundNavgtionBar()
       
        addsearchBar()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
        
        ///searchBar.tintColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
        if self.tabBarController?.selectedIndex == 1 {
            
            UIApplication.shared.isStatusBarHidden = false
            self.navigationController?.isNavigationBarHidden = false
            
            // change image background navgtionBarController
            self.navigationController?.setImageBackgroundNavgtionBar()

            modeShowPosterImage = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let backGroundImage = UIImage(named: "background_image_view.jpg")
        let imageView = UIImageView(image: backGroundImage)
        
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleToFill
        self.tableView.backgroundColor = .lightGray
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        if UIDevice.current.orientation.isPortrait {
            
            backgroundTableView()
            
        } else {
            
            backgroundTableView()
        }
    }
    
    
    // MARK: - func
    func backgroundTableView() {
        
        let backGroundImage = UIImage(named: "background_image_view.jpg")
        let imageView = UIImageView(image: backGroundImage)
        
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleToFill
        self.tableView.backgroundColor = .lightGray
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
    }
    
    // Serach To www.omdbapi.com API
    func searchTitle(_ title:String) {
        
        moviesSearchImdb.removeAll()
        
        tableView.reloadData()
        
        let titleReplacing = title.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(URL_SEARCHMOVIE_BASE)\(titleReplacing)\(API_KEY)"
        let API_URL = URL(string: urlString)!
        
        Alamofire.request(API_URL).responseJSON { response in
            
            if let dict = response.result.value as? NSDictionary {
                
                
                if let array = dict["Search"] as? NSArray{

                    let countArray = array.count
                    
                    for i in 0..<countArray {
                        
                        if let dictNew = array[i] as? NSDictionary {
                            
                            let row = MovieList(dictionary: dictNew)
                            
                            self.moviesSearchImdb.append(row)
                           
                            
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
           
        }
        
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchBarButtonItem
        
        resultSearchController.searchBar.isLoading = false

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if  searchBar.text != "" {
            
            searchBar.resignFirstResponder()
            let movieTitle = searchBar.text!
            
            searchTitle(movieTitle)
            
            resultSearchController.searchBar.isLoading = true
            searchBar.isLoading = true

        } else {
            
            resultSearchController.searchBar.isLoading = false
            searchBar.isLoading = false
            
        }
        
    }
    
    func addsearchBar() {
        
        let colorBarButtonItem = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
        searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        searchBarButtonItem.tintColor = colorBarButtonItem
        
        navigationItem.rightBarButtonItem = searchBarButtonItem
        
        self.resultSearchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false  // default true
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Search to IMDB "
            controller.searchBar.searchBarStyle = .default
            controller.searchBar.barStyle = .blackTranslucent
            controller.searchBar.tintColor = colorBarButtonItem
            
            let textFieldInsideSearchBar = controller.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = colorBarButtonItem
            
            return controller
        }()
        
        //searchBarToNavgtionBar.delegate = self
        self.resultSearchController.searchBar.delegate = self
    }
    
    
    // MARK: - tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moviesSearchImdb.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var movieSelectRow : MovieList!
        movieSelectRow = moviesSearchImdb[indexPath.row]
        idSelected = "\(movieSelectRow.imdbID)"
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchImdbCell") as? SearchToIMDBTableViewCell {
            
            //...> change background color selected
            let customColorView = UIView()
            customColorView.backgroundColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
            cell.selectedBackgroundView = customColorView
            //...<

            let movieCell : MovieList!
            movieCell = moviesSearchImdb[indexPath.row]
            cell.configureCell(movieCell)
            //activityIndicatorView.stopAnimating()
            resultSearchController.searchBar.isLoading = false
            searchBar.isLoading = false
            
            return cell
            
        } else {
            
            return SearchToIMDBTableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = .clear
        
    }
    

    // MARK: - objc func
    @objc func showSearchBar() {

        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        
        searchBar.sizeToFit()
        searchBar.placeholder = "Search to IMDB"
        searchBar.searchBarStyle = .default
        searchBar.barStyle = .blackTranslucent
        searchBar.tintColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        searchBar.setShowsCancelButton(true, animated: true)
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.becomeFirstResponder()
        
    }
    
}
