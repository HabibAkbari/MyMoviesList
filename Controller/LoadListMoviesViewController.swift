//
//  LoadListMoviesViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/14/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyPickerPopover

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

class LoadListMoviesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - outlet var
    @IBOutlet weak var tableView : UITableView!
    // MARK: - let & var
    let searchBarToNavgtionBar = UISearchBar()
    let titleLabelToNavgtionBar = UILabel()
    let filterItemArray = ["Number","Title","Actor","Year","Director","Language"]
    let searchBar = UISearchBar()
    var moviesList = [MyMoviesList]()
    var filteredMoviesList = [MyMoviesList]()
    var inSearchMode = false
    var searchBarButtonItem: UIBarButtonItem!
    var filterBarButtonItem : UIBarButtonItem!

    var actionView : UIView = UIView()
    var window : UIWindow? = nil
    var picker = UIPickerView()
    var pickerData = NSArray()
    
    //MARK: - override func
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchBar.delegate = self
        addBarButtonItem()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.setImageBackgroundNavgtionBar()

        fetchAndSetResults()
        backgroundTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchAndSetResults()
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // chage tabbar index selected
        if self.tabBarController?.selectedIndex == 0 {
            
            self.navigationController?.isNavigationBarHidden = false
            
            // change image background navgtionBarController
            self.navigationController?.setImageBackgroundNavgtionBar()
            
            modeShowPosterImage = false
        }
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        
        let newView = UIView()
        newView.backgroundColor = UIColor.red
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func fetchAndSetResults() {
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyMoviesList")
        
        do {
            
            let results = try context.fetch(fetchRequest)
            let castResults = results as! [MyMoviesList]
            self.moviesList = castResults
            self.moviesList.reverse()
            
            
        } catch  {
            
            let alert = alertMe(title: "Error", message: "The database is not loaded.", value: 100)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" || searchBar.text == nil {
            
            inSearchMode = false
            view.endEditing(true)
            tableView.reloadData()
            
        } else {
            
            inSearchMode = true
            let lower = searchBar.text
            filteredMoviesList = moviesList.filter({$0.title?.range(of: lower!) != nil })
            tableView.reloadData()
            
        }
        
    }

    func filterScopeSegmante(selectedScope: String) {
        
        switch selectedScope {
            
        case "Number" :
            if inSearchMode {
                filteredMoviesList = filteredMoviesList.sorted{$0.numberMovie!.compare($1.numberMovie!) == .orderedAscending}
                tableView.reloadData()
            }
            moviesList = moviesList.sorted{$0.numberMovie!.compare($1.numberMovie!) == .orderedAscending }
            tableView.reloadData()
        case "Title" :
            if inSearchMode {
                filteredMoviesList = filteredMoviesList.sorted(by: {$0.title < $1.title})
                tableView.reloadData()
            }
            moviesList =  moviesList.sorted(by: {$0.title < $1.title})
            tableView.reloadData()
        case "Actor" :
            if inSearchMode {
                filteredMoviesList = filteredMoviesList.sorted(by: {$0.actors < $1.actors})
                tableView.reloadData()
            }
            moviesList = moviesList.sorted(by: {$0.actors < $1.actors})
            tableView.reloadData()
        case "Year" :
            if inSearchMode {
                filteredMoviesList = filteredMoviesList.sorted(by: {$0.year < $1.year})
                tableView.reloadData()
            }
            moviesList = moviesList.sorted(by: {$0.year < $1.year})
            tableView.reloadData()
        case "Director" :
            if inSearchMode {
                filteredMoviesList = filteredMoviesList.sorted(by: {$0.director < $1.director})
                tableView.reloadData()
            }
            moviesList = moviesList.sorted(by: {$0.director < $1.director})
            tableView.reloadData()
        case "Language" :
            if inSearchMode {
                filteredMoviesList = filteredMoviesList.sorted(by: {$0.language < $1.language})
                tableView.reloadData()
            }
            moviesList = moviesList.sorted(by: {$0.language < $1.language})
            tableView.reloadData()
        default:
            return
        }
    }
    
    var resultSearchController = UISearchController()
    var searchButton: UIBarButtonItem!
    
    func crateSearchBarToNavgtionBar() {
        
        searchBarToNavgtionBar.isHidden = false
        searchBarToNavgtionBar.showsCancelButton = true
        searchBarToNavgtionBar.placeholder = "Search to list"
        searchBarToNavgtionBar.delegate = self
        searchBarToNavgtionBar.barStyle = .blackTranslucent
        searchBarToNavgtionBar.searchBarStyle = .default
        
        let colorSearchBarToNavgtionBar = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
        searchBarToNavgtionBar.tintColor = colorSearchBarToNavgtionBar
        
        let textFieldInsideSearchBar = searchBarToNavgtionBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = colorSearchBarToNavgtionBar
        
        searchBarToNavgtionBar.barTintColor = colorSearchBarToNavgtionBar
       
        self.navigationItem.titleView = searchBarToNavgtionBar
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchBarButtonItem
        self.navigationItem.leftBarButtonItem = filterBarButtonItem
        
    }
    
    func addBarButtonItem() {
        
        let colorBarButtonItem = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
        searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        searchBarButtonItem.tintColor = colorBarButtonItem
        
        filterBarButtonItem = UIBarButtonItem(image: UIImage(named: "fillter_yellow_24"), style: .done, target: self, action: #selector(showFilterPikerView(sender:)))
        filterBarButtonItem.tintColor = colorBarButtonItem
        
        navigationItem.rightBarButtonItem = searchBarButtonItem
        navigationItem.leftBarButtonItem = filterBarButtonItem
        
        self.resultSearchController = {
            
            let searchController = UISearchController(searchResultsController: nil)
            searchController.dimsBackgroundDuringPresentation = false
            searchController.hidesNavigationBarDuringPresentation = false  // default true
            searchController.searchBar.sizeToFit()
            searchController.searchBar.placeholder = "Search to list"
            searchController.searchBar.barStyle = .blackTranslucent
            searchController.searchBar.searchBarStyle = .default
            searchController.searchBar.tintColor = colorBarButtonItem
            
            let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = colorBarButtonItem
            
            return searchController
        }()
        
        self.resultSearchController.searchBar.delegate = self
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
    
    @objc func showFilterPikerView(sender: UIBarButtonItem) {
        
        
        let KSCREEN_WIDTH = UIScreen.main.bounds.width
        
        picker.frame = CGRect(x: 0.0, y: 44.0, width: KSCREEN_WIDTH, height: 216.0)
        picker.dataSource = self
        picker.delegate = self
        picker.showsSelectionIndicator = true
        picker.backgroundColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
        
        
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
        picker.selectRow(2, inComponent: 0, animated: true)
        
        //let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePicker(sender:)))
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePickerView(sender:)))
        
        pickerDateToolbar.setItems([flexibleSpace,defaultBarButtonItem,flexibleSpace,title,flexibleSpace,doneBarButtonItem,flexibleSpace] , animated: true)
        
        //pickerDateToolbar.setItems([flexibleSpace,defaultBarButtonItem,flexibleSpace,title,flexibleSpace,doneBarButtonItem,flexibleSpace] as! [UIBarButtonItem], animated: true)

        actionView.addSubview(pickerDateToolbar)
        actionView.addSubview(picker)
        
        if (window != nil) {
            window?.addSubview(actionView)
        } else {
            self.view.addSubview(actionView)
        }
        
        UIView.animate(withDuration: 0, animations: {
            self.actionView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 260.0, width: UIScreen.main.bounds.width, height: 260.0)
        })

    }

    @objc func defaultPickerView(sender: UIBarButtonItem) {
        
        fetchAndSetResults()
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
        
        let myRow = picker.selectedRow(inComponent: 0)
        print(filterItemArray[myRow])
        filterScopeSegmante(selectedScope: filterItemArray[myRow])

        
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
    
    
    // MARK: - tableView
    // Count row for table
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode {
            
            return filteredMoviesList.count
        }
        
        return  moviesList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LoadListCell") as? LoadListMoviesTableViewCell {
            
            //...> change background color selected
            let customColorView = UIView()
            customColorView.backgroundColor = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
            cell.selectedBackgroundView = customColorView
            //...<
            
            let movie: MyMoviesList!
            if inSearchMode {
                movie = filteredMoviesList[indexPath.row]
            } else {
                movie = moviesList[indexPath.row]
            }
            
            cell.configureCell(movie)
            
            return cell
        } else {
            return LoadListMoviesTableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = tableView.dequeueReusableCell(withIdentifier: "LoadListCell") as? LoadListMoviesTableViewCell
        _ = StringPickerPopover(title: "Cell "+(indexPath as NSIndexPath).row.description, choices:filterItemArray)
            
            .setSelectedRow(1)
            .setDoneButton { (popover, selectedRow, selectedString) in
                self.filterScopeSegmante(selectedScope: self.filterItemArray[selectedRow])
        }
        
        if inSearchMode {
            movieSelectRow = filteredMoviesList[indexPath.row]
        } else {
            movieSelectRow = moviesList[indexPath.row]
        }
        
    }

    // MARK: - picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterItemArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  filterItemArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        filterScopeSegmante(selectedScope: filterItemArray[row])
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
