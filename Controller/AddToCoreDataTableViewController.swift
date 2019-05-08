//
//  AddToCoreDataTableViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/9/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import Cosmos

extension UIButton {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
    }
}

extension UIView {
    
    func borderCorner(corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
    }
    
}

class AddToCoreDataTableViewController: UITableViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var showPosterBtutton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var metascoreTextField: UITextField!
    @IBOutlet weak var ratedTextField: UITextField!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var imdbVotesLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var releasedTextField: UITextField!
    @IBOutlet weak var seenButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var resolutionTextFiled: UITextField!
    @IBOutlet weak var typeTextFiled: UITextField!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var writerTextField: UITextField!
    @IBOutlet weak var awardsTextField: UITextField!
    @IBOutlet weak var plotTextView: UITextView!
    @IBOutlet var tableViewBackground: UITableView!
    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var viewAddButton: UIView!
    @IBOutlet weak var backgroundViewTitle: UIView!
    @IBOutlet weak var backgroundView00: UIView!
    @IBOutlet weak var backgroundView0: UIView!
    @IBOutlet weak var backgroundView1: UIView!
    @IBOutlet weak var backgroundView2: UIView!
    @IBOutlet weak var backgroundView3: UIView!
    
    //MARK: - let & var
    var movieList : MovieList!
    var data = Data()
    var urlImage : String {
        
        get {
            return UserDefaults.standard.object(forKey: "urlImage") as! String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "urlImage")
            UserDefaults.standard.synchronize()
        }
    }
    var imagePicker : UIImagePickerController!
    var modePosterButton : Bool {
        get {
            return UserDefaults.standard.object(forKey: "modePosterButton") as! Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "modePosterButton")
            UserDefaults.standard.synchronize()
        }
    }

    //MARK: - override func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // fix buttom session 0
        
        backgroundTableView()
        downloadCompeletDetails()
        editUI()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if self.tabBarController?.selectedIndex == 1 {
            
            modeShowPosterImage = true
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 0.0
        }
        
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //view.tintColor = UIColor(red: 56/255, green: 58/255, blue: 58/255, alpha: 1)
        
        //view.tintColor = UIColor(red: 64/255, green: 54/255, blue: 54/255, alpha: 1)
        view.tintColor = UIColor.black
        view.alpha = 0.1
        
        let headerAndFoother = view as! UITableViewHeaderFooterView
        headerAndFoother.textLabel?.textColor = UIColor.white
        
        if section == 0 {
            
        }
        
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        if UIDevice.current.orientation.isPortrait {
            
            backgroundTableView()
            ratingView.settings.starSize = 13
            ratingView.settings.textFont = UIFont(name: "Helvetica", size: 13)!
            tableViewBackground.reloadData()
            
        } else {
            
            backgroundTableView()
            ratingView.settings.starSize = 30
            ratingView.settings.textFont = UIFont(name: "Helvetica", size: 30)!
            tableViewBackground.reloadData()
            
        }
        
    }
    
    // MARK: - Func
    func backgroundTableView() {
        
        let backGroundImage = UIImage(named: "background_image_view.jpg")
        let imageView = UIImageView(image: backGroundImage)
        self.tableViewBackground.backgroundView = imageView
        imageView.contentMode = .scaleToFill
        self.tableViewBackground.backgroundColor = .lightGray
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
    }
    func downloadCompeletDetails () {
        
        let urlString = "\(URL_SEARCHMOVIE_ID)\(idSelected!)\(URL_SEARCHMOVIE_PATH)\(API_KEY)"
        let url = URL(string: urlString)!
        
        Alamofire.request(url).responseJSON {response in
            if let dict = response.result.value as? NSDictionary {
                self.movieList =   MovieList.init(dictionaryDetails: dict)
                
                self.updateUI(self.movieList)
            }
            
        }
        
    }
    func updateUI(_ movielist:MovieList){
        
        self.movieList = movielist
        titleLabel.text = movielist.title
        yearTextField.text = movielist.year
        directorTextField.text = movielist.director
        actorsLabel.text = movielist.actors
        imdbVotesLabel.text = movielist.imdbVotes
        runTimeLabel.text = movielist.runtime
        releasedTextField.text = movielist.released
        resolutionTextFiled.text = "1080_mkv"
        typeTextFiled.text = movielist.type
        genreLabel.text = movielist.genre
        languageTextField.text = movielist.language
        countryTextField.text = movielist.country
        writerTextField.text = movielist.writer
        awardsTextField.text = movielist.awards
        metascoreTextField.text = movieList.metascore
        plotTextView.text = "Plot : \(movieList.plot)"
        
        urlImage = movieList.poster
        
        if let url = URL(string: "\(movieList.poster)") {
            
            data = try! Data(contentsOf: url)
            showPosterImageView.image = UIImage(data: data)
            
        }
        
        ratedTextField.text = movieList.rated
        let rating = Double( movieList.imdbRating)!
        ratingView.text = movieList.imdbRating
        ratingView.rating =  rating/2
        ratingView.settings.updateOnTouch = false
    }
    func editUI() {
        
        viewAddButton.borderCorner(corners: [.topLeft,.bottomLeft], radius: 15)
        self.navigationController?.isNavigationBarHidden = true
        
        // scrooling
        tableViewBackground.contentInset = UIEdgeInsetsMake(-3, 0, 0, 0)
        
        backgroundViewTitle.layer.cornerRadius = 20
        backgroundView0.layer.cornerRadius = 20
        backgroundView00.layer.cornerRadius = 20
        backgroundView1.layer.cornerRadius = 20
        backgroundView2.layer.cornerRadius = 20
        backgroundView3.layer.cornerRadius = 20
        
        resolutionTextFiled.layer.cornerRadius = 5
        typeTextFiled.layer.cornerRadius = 5
        ratedTextField.layer.cornerRadius = 5
        metascoreTextField.layer.cornerRadius = 5
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    //MARK: - objc func
    @objc func addMovie() {
        
        var numberM = 0
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "MyMoviesList", in: managedContext)
        let requst = NSFetchRequest<NSFetchRequestResult>()
        
        requst.entity = entityDescription
        
        do {
            
            let res = try! managedContext.fetch(requst)
            
            if res.count == 0 {
                numberM = 1
                
            } else {
                
                let match = res.last as! NSManagedObject
                var number = match.value(forKey: "numberMovie") as! Int
                number += 1
                numberM = number
                
            }
        }
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyMoviesList")
        let predicateTitle = NSPredicate(format:"imdbID == %@", idSelected)
        
        fetchRequest.predicate = predicateTitle
        
        let results = try! managedContext.fetch(fetchRequest)
        var seoredResults = [NSManagedObject]()
        seoredResults = results as! [NSManagedObject]
        
        if seoredResults.count == 0 {
            
            let entity = NSEntityDescription.entity(forEntityName: "MyMoviesList", in: managedContext)!
            
            let myMovieList = MyMoviesList(entity: entity, insertInto: managedContext)
            
            
            myMovieList.title = titleLabel.text!
            myMovieList.setMovieListImg(UIImage(data: data)!)
            myMovieList.poster = "\(titleLabel.text!).jpg"
            myMovieList.year = yearTextField.text!
            myMovieList.director = directorTextField.text!
            myMovieList.actors = actorsLabel.text!
            myMovieList.rated = ratedTextField.text!
            myMovieList.metascore = metascoreTextField.text!
            myMovieList.imdbRating = ratingView.text!
            myMovieList.imdbVotes = imdbVotesLabel.text!
            myMovieList.runtime = runTimeLabel.text!
            myMovieList.released = releasedTextField.text!
            myMovieList.resolution = "1080_mkv"
            myMovieList.genre = genreLabel.text!
            myMovieList.language = languageTextField.text!
            myMovieList.country = countryTextField.text!
            myMovieList.type = typeTextFiled.text!
            myMovieList.writer = writerTextField.text!
            myMovieList.awards = awardsTextField.text!
            myMovieList.plot = plotTextView.text
            myMovieList.imdbID = idSelected
            myMovieList.numberMovie = numberM as NSNumber?
            myMovieList.favorite = false
            myMovieList.view = false
            
            managedContext.insert(myMovieList)
            
            do {
                
                try managedContext.save()
                
            } catch {
                
                let alert  = alertMe(title: "Error", message: "Could not add to the list.", value: 100)
                self.present(alert, animated: true, completion: nil)
            }
            
            _ =  self.navigationController?.popToRootViewController(animated: true)
            
            self.navigationController?.setImageBackgroundNavgtionBar()
            self.navigationController?.isNavigationBarHidden = false
            UIApplication.shared.isStatusBarHidden = false
            
        } else
        {
            
            let alert = UIAlertController(title: "Message", message: "The film is available in your list!", preferredStyle: UIAlertControllerStyle.alert)
            let backToSearch:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (a: UIAlertAction) -> Void in
                
                let _ =  self.navigationController?.popToRootViewController(animated: true)
                self.navigationController?.setImageBackgroundNavgtionBar()
                
                self.navigationController?.isNavigationBarHidden = false
                UIApplication.shared.isStatusBarHidden = false
            }
            
            alert.addAction(backToSearch)
            self.present(alert, animated: true, completion: nil)
            self.navigationController?.setImageBackgroundNavgtionBar()
        }
        
    }
    @objc func tapResetButton() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        
        // back to root
        _ = self.navigationController?.popViewController(animated: true)
        
        self.navigationController?.setImageBackgroundNavgtionBar()
    }
    
    //MARK: - Action
    @IBAction func backButton(_ sender: Any) {
        
        let _ =  self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.setImageBackgroundNavgtionBar()
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.isStatusBarHidden = false
        
    }
    @IBAction func addMovieToListButton(_ sender: Any) {
        
        addMovie()
        
    }
    @IBAction func showPosterBtutton(_ sender: Any) {
        
        modeShowPosterImage = true
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let objShowFullPoster = storyboard.instantiateViewController(withIdentifier: "ShowFullPosterID") as! ShowFullPosterViewController
        self.present(objShowFullPoster, animated: true, completion: nil)
 
    }
    
}
