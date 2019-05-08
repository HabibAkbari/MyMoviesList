//
//  EditToCoreDataTableViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/17/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//


import UIKit
import Cosmos

// Set Title & HiddanTitle For button Poster
extension UIButton {
    
    func titleButton(title:String) {
        
        self.setTitle(title, for: UIControlState.normal)
        self.tintColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        self.isHighlighted = true
        
    }
    
    func hiddanTitle(title:String) {
        
        self.setTitle(title, for: UIControlState.normal)
        self.isHighlighted = false
        
    }
    
}
extension UIImageView {
    
    func addGrsdientLayer(frame: CGRect, colors: [UIColor]) {
        
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
        
    }
    
}

class EditToCoreDataTableViewController: UITableViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBOutlet weak var
    @IBOutlet weak var switchEditButton: UISwitch!
    @IBOutlet weak var showAndSelectPosterBtutton: UIButton!
    @IBOutlet weak var showPosterImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var actorsTextField: UITextField!
    @IBOutlet weak var metascoreTextField: UITextField!
    @IBOutlet weak var ratedTextField: UITextField!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var imdbVotesLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var releasedTextField: UITextField!
    @IBOutlet weak var seenButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var resolutionTextFiled: UITextField!
    @IBOutlet weak var typeTextFiled: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var writerTextField: UITextField!
    @IBOutlet weak var awardsTextField: UITextField!
    @IBOutlet weak var plotTextView: UITextView!
    @IBOutlet weak var numberMovieLabel: UILabel!
    @IBOutlet var tableViewBackground: UITableView!
    @IBOutlet weak var backgroundViewTRN: UIView!
    @IBOutlet weak var backgroundViewSMYF: UIView!
    @IBOutlet weak var backgroundViewGA: UIView!
    @IBOutlet weak var backgroundViewTRMR: UIView!
    @IBOutlet weak var backgroundViewDLWCAR: UIView!
    @IBOutlet weak var backgroundViewPolt: UIView!
    @IBOutlet weak var viewSwitch: UIView!
    
    // MARK: - let & var
    var movieList : MyMoviesList!
    var switchFavorite : Bool! = false
    var switchView  : Bool! = false
    var imagePicker : UIImagePickerController!
    var pickerViewArray : [String] = []
    var resolutionArray : [String] = []
    var modePosterButton : Bool {
        get {
            return UserDefaults.standard.object(forKey: "modePosterButton") as! Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "modePosterButton")
            UserDefaults.standard.synchronize()
        }
    }
    var pickerView = UIPickerView()
    var actionView : UIView = UIView()
    var window : UIWindow? = nil
    var tagTextFiled = 0
    
   
    // MARK: - override func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        modePosterButton = false
        
        updateUI()
        editUI()
        
        typeTextFiled.inputView = pickerView
        yearTextField.inputView = pickerView
        resolutionTextFiled.inputView = pickerView
        

    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        if UIDevice.current.orientation.isPortrait {
            
            backgroundTableView()
            ratingView.settings.starSize = 15
            ratingView.settings.textFont = UIFont(name: "Helvetica", size: 25)!
            tableView.reloadData()
            
        } else {
            
            backgroundTableView()
            ratingView.settings.starSize = 45;
            ratingView.settings.textFont = UIFont(name: "Helvetica", size: 45)!
            tableView.reloadData()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if self.tabBarController?.selectedIndex == 1 {
            modeShowPosterImage = false
        }
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0.0
        }
        return UITableViewAutomaticDimension
        
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 0.5)
        
        return view
        
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
    func updateUI() {
        
        showPosterImageView.image = movieSelectRow.getMovieListImg()
        numberMovieLabel.text = "\(movieSelectRow.numberMovie!)"
        titleTextField.text = movieSelectRow.title
        yearTextField.text = movieSelectRow.year
        directorTextField.text = movieSelectRow.director
        actorsTextField.text = movieSelectRow.actors
        runtimeLabel.text = movieSelectRow.runtime
        metascoreTextField.text = movieSelectRow.metascore
        ratedTextField.text = movieSelectRow.rated
        resolutionTextFiled.text = movieSelectRow.resolution
        typeTextFiled.text = movieSelectRow.type
        imdbVotesLabel.text = movieSelectRow.imdbVotes
        releasedTextField.text = movieSelectRow.released
        genreTextField.text = movieSelectRow.genre
        languageTextField.text = movieSelectRow.language
        countryTextField.text = movieSelectRow.country
        writerTextField.text = movieSelectRow.writer
        awardsTextField.text = movieSelectRow.awards
        plotTextView.text = movieSelectRow.plot
        
        ratingView.text = movieSelectRow.imdbRating
        let rating = Double(ratingView.text!)
        ratingView.rating = rating!/2
        ratingView.settings.updateOnTouch = false
        
        if movieSelectRow.favorite == true {
            favoriteButton.setImage(UIImage(named: "heartRead.png" ), for: UIControlState.normal)
            switchFavorite = true
        } else {
            favoriteButton.setImage(UIImage(named: "heartLightGray.png" ), for: UIControlState.normal)
            switchFavorite = false
        }
        
        if movieSelectRow.view == true {
            seenButton.setImage(UIImage(named: "viewYallow.png"), for: UIControlState.normal)
            switchView = true
        } else {
            seenButton.setImage(UIImage(named: "viewLightGray.png"), for: UIControlState.normal)
            switchView = false
        }
        
    }
    func year() {
        
        for year in (1970..<2050).reversed() {
            pickerViewArray.append("\(year)")
        }
    }
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let frame =  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 200)
        let expiryDatePicker = MonthYearPickerView()
        expiryDatePicker.onDateSelected = {(month: Int, year: Int) in
            
            let string = String(format: "%02d/%d", month, year)
            print(string)
        }
        
        expiryDatePicker.frame = frame
        view.addSubview(expiryDatePicker)
        
    }
    func editInformation() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mangedContext = appDelegate.managedObjectContext
        
        movieSelectRow.setValue(actorsTextField.text , forKey: "actors")
        movieSelectRow.setValue(awardsTextField.text , forKey: "awards")
        movieSelectRow.setValue(countryTextField.text , forKey: "country")
        movieSelectRow.setValue(directorTextField.text , forKey: "director")
        movieSelectRow.setValue(genreTextField.text, forKey: "genre")
        movieSelectRow.setValue(languageTextField.text , forKey: "language")
        movieSelectRow.setValue(plotTextView.text , forKey: "plot")
        movieSelectRow.setValue(releasedTextField.text , forKey: "released")
        movieSelectRow.setValue(runtimeLabel.text, forKey: "runtime")
        movieSelectRow.setValue(titleTextField.text , forKey: "title")
        movieSelectRow.setValue("\(titleTextField.text!).jpg", forKey: "poster")
        
        let posterImageView = showPosterImageView.image as! UIImage
        movieSelectRow.setMovieListImg(posterImageView)
        movieSelectRow.setValue(typeTextFiled.text , forKey: "type")
        movieSelectRow.setValue(writerTextField.text , forKey: "writer")
        movieSelectRow.setValue(yearTextField.text , forKey: "year")
        movieSelectRow.setValue(switchFavorite, forKey: "favorite")
        movieSelectRow.setValue(switchView, forKey: "view")
        movieSelectRow.setValue(resolutionTextFiled.text, forKey: "resolution")
        
        do {
            
            try mangedContext.save()
            
            let _ =  self.navigationController?.popToRootViewController(animated: true)
            UIApplication.shared.isStatusBarHidden = false
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.setImageBackgroundNavgtionBar()
            
            
        } catch {
            
            let alert = alertMe(title: "Error", message: "You can not edit.", value: 100)
            self.present(alert, animated: true, completion: nil)
            self.navigationController?.isNavigationBarHidden = false
            UIApplication.shared.isStatusBarHidden = false
            self.navigationController?.setImageBackgroundNavgtionBar()
            
        }
    }
    func changeViewEditObject() {
        
        if switchEditButton.isOn {
            
            self.view.isUserInteractionEnabled = true
            
            showAndSelectPosterBtutton.titleButton(title: "⊕")
            titleTextField.customTextFiled(switchFlag: true)
            yearTextField.customTextFiled(switchFlag: true)
            directorTextField.customTextFiled(switchFlag: true)
            actorsTextField.customTextFiled(switchFlag: true)
            releasedTextField.customTextFiled(switchFlag: true)
            genreTextField.customTextFiled(switchFlag: true)
            languageTextField.customTextFiled(switchFlag: true)
            countryTextField.customTextFiled(switchFlag: true)
            writerTextField.customTextFiled(switchFlag: true)
            awardsTextField.customTextFiled(switchFlag: true)
            typeTextFiled.customTextFiled(switchFlag: true)
            resolutionTextFiled.customTextFiled(switchFlag: true)
            seenButton.customButton(switchFlag: true)
            favoriteButton.customButton(switchFlag: true)
            plotTextView.customTextView(switchFlag: true)
            
            tableViewBackground.reloadData()
            modePosterButton = true
            
        } else {
            
            self.view.isUserInteractionEnabled = false
            
            showAndSelectPosterBtutton.hiddanTitle(title: "")
            titleTextField.customTextFiled(switchFlag: false)
            yearTextField.customTextFiled(switchFlag: false)
            directorTextField.customTextFiled(switchFlag: false)
            actorsTextField.customTextFiled(switchFlag: false)
            releasedTextField.customTextFiled(switchFlag: false)
            genreTextField.customTextFiled(switchFlag: false)
            languageTextField.customTextFiled(switchFlag: false)
            countryTextField.customTextFiled(switchFlag: false)
            writerTextField.customTextFiled(switchFlag: false)
            awardsTextField.customTextFiled(switchFlag: false)
            resolutionTextFiled.customTextFiled(switchFlag: false)
            typeTextFiled.backgroundColor = UIColor(red: 53/256, green: 138/256, blue: 34/256, alpha: 1.0)
            typeTextFiled.tintColor = UIColor.white
            typeTextFiled.layer.cornerRadius = 0.0
            typeTextFiled.layer.borderColor = UIColor.clear.cgColor
            typeTextFiled.isUserInteractionEnabled = false
            seenButton.customButton(switchFlag: false)
            favoriteButton.customButton(switchFlag: false)
            plotTextView.customTextView(switchFlag: false)
            
            editInformation()
            tableViewBackground.reloadData()
            modePosterButton = false
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        showPosterImageView.contentMode = .scaleAspectFit
        showPosterImageView.image = chosenImage
        
        dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    func showPikerView() {
        
        
        let KSCREEN_WIDTH = UIScreen.main.bounds.width
        
        pickerView.frame = CGRect(x: 0.0, y: 44.0, width: KSCREEN_WIDTH, height: 216.0)
        //pickerView.frame =  CGRect(x: 0, y: 344.0, width: KSCREEN_WIDTH, height: 216.0)
        //pickerView.frame =  CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 216.0)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.showsSelectionIndicator = true
        pickerView.backgroundColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
        
        let pickerDateToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        pickerDateToolbar.barStyle = UIBarStyle.blackTranslucent
        pickerDateToolbar.barTintColor = UIColor.black
        pickerDateToolbar.tintColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        pickerDateToolbar.isTranslucent = true
        
        let defaultBarButtonItem = UIBarButtonItem(title: "Default", style: .plain, target: self, action: #selector(defaultPickerView(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let title = UIBarButtonItem(title: "Select Item", style: .plain, target: self, action: nil)
        title.isEnabled = false
        title.tintColor = UIColor.white
        
        //pickerData = filterItemArray as NSArray
        pickerView.selectRow(2, inComponent: 0, animated: true)
        
        //let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker(sender:)))
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePickerView(sender:)))
        
        pickerDateToolbar.setItems([flexibleSpace,defaultBarButtonItem,flexibleSpace,title,flexibleSpace,doneBarButtonItem,flexibleSpace] , animated: true)
        
        //pickerDateToolbar.setItems([flexibleSpace,defaultBarButtonItem,flexibleSpace,title,flexibleSpace,doneBarButtonItem,flexibleSpace] as! [UIBarButtonItem], animated: true)
        
        yearTextField.inputAccessoryView = pickerDateToolbar
        resolutionTextFiled.inputAccessoryView = pickerDateToolbar
        typeTextFiled.inputAccessoryView = pickerDateToolbar
        
        
    }
    func editUI() {
        
        // Corner Radius Switch
        viewSwitch.borderCorner(corners: [.topLeft,.bottomLeft], radius: 15)
        
        // Corner Raddius View
        backgroundViewTRN.layer.cornerRadius = 20
        backgroundViewSMYF.layer.cornerRadius = 20
        backgroundViewGA.layer.cornerRadius = 20
        backgroundViewTRMR.layer.cornerRadius = 20
        backgroundViewDLWCAR.layer.cornerRadius = 20
        backgroundViewPolt.layer.cornerRadius = 20
        
        let imageBackgroundInformation = UIImage(named: "backGroundLanuchScreen")
        let imageViewBackgroundInformationView = UIImageView(image: imageBackgroundInformation)
        imageViewBackgroundInformationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Corner Raddius TextFiled
        resolutionTextFiled.layer.cornerRadius = 5
        typeTextFiled.layer.cornerRadius = 5
        ratedTextField.layer.cornerRadius = 5
        metascoreTextField.layer.cornerRadius = 5
        yearTextField.layer.cornerRadius = 5
        
        // Size Scrolling table View
        tableViewBackground.contentInset = UIEdgeInsetsMake(-3, 0, 0, 0)
        
        // Navigtion Bar Hidden On
        self.navigationController?.isNavigationBarHidden = true
        
        UIApplication.shared.isStatusBarHidden = true
        
        // change background view func
        backgroundTableView()
    }
    
    // MARK: - piker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  pickerViewArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if yearTextField.isFirstResponder {
            
            yearTextField.text =   pickerViewArray[row]
            
        } else if resolutionTextFiled.isFirstResponder {
            
            resolutionTextFiled.text =   pickerViewArray[row]
            
        } else if typeTextFiled.isFirstResponder {
            
            typeTextFiled.text = pickerViewArray[row]
            
        }
        
    }
    
    //MARK: - objc func
    @objc func defaultPickerView(sender: UIBarButtonItem) {
        
        // select default item
        if tagTextFiled == 0 {
             yearTextField.text = movieSelectRow.year
        } else if tagTextFiled == 1 {
            typeTextFiled.text = movieSelectRow.type
        } else {
            resolutionTextFiled.text = movieSelectRow.resolution
        }
       
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.actionView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 260.0)
        }) { (true) in
            for obj: AnyObject in self.actionView.subviews {
                if let view = obj as? UIView {
                    view.removeFromSuperview()
                }
            }
        }
        
    }
    @objc func donePickerView(sender: UIBarButtonItem) {
        
        tableView.reloadData()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.actionView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 260.0)
        }) { (true) in
            for obj: AnyObject in self.actionView.subviews {
                if let view = obj as? UIView {
                    view.removeFromSuperview()
                }
            }
        }
        
    }

    // MARK: - Action func
    @IBAction func backButton(_ sender: Any) {
        
        let _ =  self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.setImageBackgroundNavgtionBar()
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.isStatusBarHidden = false
        
    }
    @IBAction func editSwitchButton(_ sender: Any) {
        
        changeViewEditObject()
        
    }
    // selecte Favorite,Seen and Show Poster
    @IBAction func selectedFavoriteButton(_ sender: Any) {
        
        if switchFavorite == false {
            
            favoriteButton.setImage(UIImage(named: "heartRead.png" ), for: UIControlState.normal)
            switchFavorite = true
            
        } else {
            
            favoriteButton.setImage(UIImage(named: "heartlightGray.png" ), for: UIControlState.normal)
            switchFavorite = false
            
        }
        
    }
    @IBAction func selectedSeenButton(_ sender: Any) {
        
        if switchView == false {
            
            seenButton.setImage(UIImage(named: "viewYallow.png"), for: UIControlState.normal)
            switchView = true
            
        } else {
            
            seenButton.setImage(UIImage(named: "viewlightGray.png"), for: UIControlState.normal)
            switchView = false
        }
    }
    @IBAction func showAndSelectPosterBtutton(_ sender: Any) {
        
        if modePosterButton == true {
            
            present(imagePicker, animated: true, completion: nil)
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let objShowFullPoster = storyboard.instantiateViewController(withIdentifier: "ShowFullPosterID") as! ShowFullPosterViewController
            self.present(objShowFullPoster, animated: true, completion: nil)
        }
        
    }
    // select Type,Resolution And Year
    @IBAction func selectType(_ sender: UITextField) {
        
        tagTextFiled = typeTextFiled.tag
        pickerViewArray.removeAll()
        pickerViewArray = ["movie","series","animation","documentary","sport","ohter"]
        
        showPikerView()
    
    }
    @IBAction func selectResolution(_ sender: UITextField) {
        
        tagTextFiled = resolutionTextFiled.tag
        pickerViewArray.removeAll()
        pickerViewArray = ["1080_mkv","720_mkv","420_mkv","DVD","Ohter"]
        
        showPikerView()
        
    }
    @IBAction func selectYear(_ sender: UITextField) {
        
        tagTextFiled = yearTextField.tag
        pickerViewArray.removeAll()
        year()
        showPikerView()
        
    }

}
