//
//  BackUpAndRestoreViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/19/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import UIKit
import CoreData

class BackUpAndRestoreViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backUpBtn: UIButton!
    @IBOutlet weak var restoreBackUpBtn: UIButton!
    @IBOutlet weak var removeBackUpImageBtn: UIButton!
    @IBOutlet weak var scrollingView: UIScrollView!
    
    // MARK; - var
    var List : Array<MyMoviesList> = []
    var moviesList = [MyMoviesList]()
    var flag = true
    var flagProcessFunc = false
    var countBackUpMovie = 0
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change background navgtion bar
        self.navigationController?.setImageBackgroundNavgtionBar()
        
        // scrolling
        scrollingView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
        
        backgroundImageView.addBlurEffect()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @IBAction func backUp(_ sender: Any) {
        
        if flag == true {
            
            let alert:UIAlertController = UIAlertController(title: "BackUp", message: "Save the backup in svc file.", preferredStyle: .alert)
            
            let actionStart:UIAlertAction = UIAlertAction(title: "Start", style: UIAlertActionStyle.default) { (a: UIAlertAction) -> Void in
                
                
                self.svprogressHUD(titleAction: "backup", titleSVProgress: "Backup...")
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    if  self.backUpToCsv() == true {
                        
                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            
                            let alert:UIAlertController = UIAlertController(title: "Message", message: "Complete backup of \(self.countBackUpMovie) movie.", preferredStyle: .alert)
                            
                            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) in
                                
                                self.stopProgress(flagProsses: true, titleButton: "backup")
                            })
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                        
                    }  else {
                        
                        if self.flagProcessFunc != false {
                            
                            SVProgressHUD.dismiss()
                            let alert:UIAlertController = UIAlertController(title: "Error", message: "Can not backUp.", preferredStyle: .alert)
                            
                            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) in
                                
                                self.stopProgress(flagProsses: true, titleButton: "backup")
                            })
                            
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                        } else {
                            self.stopProgress(flagProsses: true, titleButton: "backup")
                        }
                        
                        
                    }
                    
                }
                
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            alert.addAction(actionStart)
            alert.addAction(actionCancel)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            SVProgressHUD.dismiss()
            stopProgress(flagProsses: false, titleButton: "backup")
            
        }
        
    }
    
    @IBAction func restoreBackUp(_ sender: Any) {
        
        if flag == true {
            
            let alert:UIAlertController = UIAlertController(title: "Restore BackUp", message: "Remove all data current.", preferredStyle: .alert)
            
            let actionStart:UIAlertAction = UIAlertAction(title: "Start", style: UIAlertActionStyle.default) { (a: UIAlertAction) ->Void in
                
                self.svprogressHUD(titleAction: "restore", titleSVProgress: "Restore backUp...")
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    if self.restoreBackUpCsvFile() == true {
                        
                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            
                            let alert:UIAlertController = UIAlertController(title: "Message", message: "Complete restore backup \(self.countBackUpMovie) movie", preferredStyle: .alert)
                            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) in
                                
                                self.stopProgress(flagProsses: true, titleButton: "restore")
                            })
                            
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                        
                        
                    } else {
                        
                        if self.flagProcessFunc != false {
                            
                            let alert:UIAlertController = UIAlertController(title: "Error", message: "Can not restore backup.", preferredStyle: .alert)
                            
                            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) in
                                
                                self.stopProgress(flagProsses: true, titleButton: "backup")
                            })
                            
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                            
                        } else {
                            
                            self.stopProgress(flagProsses: true, titleButton: "backup")
                        }
                        
                    }
                    
                }
                
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            alert.addAction(actionStart)
            alert.addAction(actionCancel)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            SVProgressHUD.dismiss()
            self.stopProgress(flagProsses: false, titleButton: "restore")
            
        }
        
    }
    
    @IBAction func removeBackUp(_ sender: Any) {
        
        
        if flag == true {
            
            let alert:UIAlertController = UIAlertController(title: "Remove", message: "Remove all current data all images and backup", preferredStyle: .alert)
            let actionStart:UIAlertAction = UIAlertAction(title: "Start", style: UIAlertActionStyle.default) { (a: UIAlertAction) ->Void in
                
                self.svprogressHUD(titleAction: "remove", titleSVProgress: "Remove data and backup...")
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    if self.removeDirectory() != false {
                        
                        DispatchQueue.main.async {
                            
                            SVProgressHUD.dismiss()
                            
                            let alert:UIAlertController = UIAlertController(title: "Message", message: "Complete", preferredStyle: .alert)
                            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) in
                                
                                self.stopProgress(flagProsses: true, titleButton: "remove")
                                
                            })
                            
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    } else {
                        
                        SVProgressHUD.dismiss()
                        let alert:UIAlertController = UIAlertController(title: "Error", message: "Not remove  image and backup.", preferredStyle: .alert)
                        
                        let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) in
                            
                            self.stopProgress(flagProsses: true, titleButton: "remove")
                        })
                        
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
            alert.addAction(actionStart)
            alert.addAction(actionCancel)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            SVProgressHUD.dismiss()
            self.stopProgress(flagProsses: false, titleButton: "remove")
            
        }
        
    }
    
    // MARK: - BackUp CSV
    func fetch() -> Array<AnyObject> {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyMoviesList")
        
        do {
            
            List = try context.fetch(request) as! Array<MyMoviesList>
            
        } catch {
            
            List = []
            return List
            
        }
        
        return List
    }
    
    func backUpToCsv() -> Bool {
        
        
        let contentToWrite = convertFtechToCsvString(transactions: fetch())
        
        if  contentToWrite != "" {
            
            let path = "\(getDirectoryPath())/MovieList.csv"
            
            do {
                
                try contentToWrite.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
                
            } catch {
                
                return false
            }
            
            return true
            
        } else {
            
            return false
        }
        
    }
    
    func convertFtechToCsvString(transactions: Array<AnyObject>) ->  String {
        
        var result = ""
        countBackUpMovie = 0
        
        for item in List {
            
            if flagProcessFunc == true {
                
                result += "\""+","
                result = result+"\""+(item.title)!+"\""+","
                result = result+"\""+(item.year)!+"\""+","
                result = result+"\""+(item.rated)!+"\""+","
                result = result+"\""+(item.released)!+"\""+","
                result = result+"\""+(item.runtime)!+"\""+","
                result = result+"\""+(item.genre)!+"\""+","
                result = result+"\""+(item.director)!+"\""+","
                result = result+"\""+(item.writer)!+"\""+","
                result = result+"\""+(item.actors)!+"\""+","
                result = result+"\""+(item.plot)!+"\""+","
                result = result+"\""+(item.language)!+"\""+","
                result = result+"\""+(item.country)!+"\""+","
                result = result+"\""+(item.awards)!+"\""+","
                result = result+"\""+(item.metascore)!+"\""+","
                result = result+"\""+(item.imdbRating)!+"\""+","
                result = result+"\""+(item.imdbVotes)!+"\""+","
                result = result+"\""+(item.imdbID)!+"\""+","
                result = result+"\""+(item.type)!+"\""+","
                result = result+"\""+(String(describing: item.numberMovie!))+"\""+","
                result = result+"\""+(String(item.favorite))+"\""+","
                result = result+"\""+(String(item.view))+"\""+","
                result = result+"\""+(item.resolution)+"\""+","
                result = result+"\""+(item.poster)!+"\""+","
                result = result+"\""+"\r"
                
                countBackUpMovie += 1
                
            } else {
                result = ""
                return result
            }
        }
        
        return result
    }
    
    // MARK: - RestoreBackUp CSV
    func restoreBackUpCsvFile() -> Bool {
        
        do {
            
            let csvPath = "\(getDirectoryPath())/MovieList.csv"
  
            let csvData = try String(contentsOfFile: csvPath, encoding: String.Encoding.utf8)
            
            countBackUpMovie = 0
            
            if removeAllData() == true {
                
                let arraySeparateStar = csvData.components(separatedBy: "*")
                
                for item in arraySeparateStar {
                    
                    let arraySeparateBackSlashesR = item.components(separatedBy: "\r")
                    
                    for item in arraySeparateBackSlashesR {
                        
                        if self.flagProcessFunc != false {
                            
                            
                            let arraySeparateTwoBackSlashes = item.components(separatedBy: "\",\"")
                            //spert
                            if item != "" {
                                
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                let managedContext = appDelegate.managedObjectContext
                                let entity = NSEntityDescription.entity(forEntityName: "MyMoviesList", in: managedContext)
                                let myMovieList = MyMoviesList(entity: entity!, insertInto: managedContext)
                                
                                myMovieList.title = arraySeparateTwoBackSlashes[1]
                                myMovieList.year = arraySeparateTwoBackSlashes[2]
                                myMovieList.rated = arraySeparateTwoBackSlashes[3]
                                myMovieList.released = arraySeparateTwoBackSlashes[4]
                                myMovieList.runtime = arraySeparateTwoBackSlashes[5]
                                myMovieList.genre = arraySeparateTwoBackSlashes[6]
                                myMovieList.director = arraySeparateTwoBackSlashes[7]
                                myMovieList.writer = arraySeparateTwoBackSlashes[8]
                                myMovieList.actors = arraySeparateTwoBackSlashes[9]
                                myMovieList.plot = arraySeparateTwoBackSlashes[10]
                                myMovieList.language = arraySeparateTwoBackSlashes[11]
                                myMovieList.country = arraySeparateTwoBackSlashes[12]
                                myMovieList.awards = arraySeparateTwoBackSlashes[13]
                                myMovieList.metascore = arraySeparateTwoBackSlashes[14]
                                myMovieList.imdbRating = arraySeparateTwoBackSlashes[15]
                                myMovieList.imdbVotes = arraySeparateTwoBackSlashes[16]
                                myMovieList.imdbID = arraySeparateTwoBackSlashes[17]
                                myMovieList.type = arraySeparateTwoBackSlashes[18]
                                myMovieList.numberMovie = Int(arraySeparateTwoBackSlashes[19]) as NSNumber?
                                myMovieList.favorite = Bool(arraySeparateTwoBackSlashes[20])!
                                myMovieList.view = Bool(arraySeparateTwoBackSlashes[21])!
                                myMovieList.resolution = arraySeparateTwoBackSlashes[22]
                                myMovieList.poster = arraySeparateTwoBackSlashes[23]
                                
                                //                                for var i in 0...100000 {
                                //                                    i += 1
                                //                                    print(i)
                                //                                }
                                
                                managedContext.insert(myMovieList)
                                
                                do {
                                    
                                    try managedContext.save()
                                    countBackUpMovie += 1
                                    
                                } catch {
                                    
                                    return false
                                    
                                }
                                
                            }
                        } else {
                            return false
                        }
                        
                    }
                }
                
            } else {
                
                return false
            }
            
        } catch {
            
            SVProgressHUD.dismiss()
            let alert:UIAlertController = UIAlertController(title: "Error", message: "Can not read backup file.", preferredStyle: .alert)
            
            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) in
                
                self.stopProgress(flagProsses: true, titleButton: "remove")
            })
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            return false
            
        }
        
        return true
    }
    
    func removeAllData() ->  Bool {
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let requestFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MyMoviesList")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: requestFetch)
        
        do {
            
            try context.execute(deleteRequest)
            try context.save()
            
        } catch {
            
            return false
        }
        
        return true
        
    }
    
    func svprogressHUD(titleAction: String, titleSVProgress:String) {
        
        if titleAction == "backup" {
            
            changeImageAndTitleButtom(selectNumber: 0, flag: true)
            
        } else if titleAction == "restore" {
            
            changeImageAndTitleButtom(selectNumber: 1, flag: true)
            
        } else {
            
            changeImageAndTitleButtom(selectNumber: 2, flag: true)
        }
        
        flag = false
        flagProcessFunc = true
        self.stateTabBar(bool: false)
        
        SVProgressHUD.setBackgroundColor(UIColor(red: 104/255, green: 104/255, blue: 104/255, alpha: 1.0))
        SVProgressHUD.setForegroundColor(UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0))
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 1, vertical: -70))
        SVProgressHUD.show(withStatus: "\(titleSVProgress)")
    }
    
    // MARK: - other func
    func stopProgress(flagProsses:Bool, titleButton: String)  {
        
        
        if titleButton == "backup" {
            
            changeImageAndTitleButtom(selectNumber: 0, flag: false)
            
        } else if titleButton == "restore" {
            
            changeImageAndTitleButtom(selectNumber: 1, flag: false)
            
        } else {
            
            changeImageAndTitleButtom(selectNumber: 2, flag: false)
        }
        
        self.flagProcessFunc = false
        self.flag = true
        self.stateTabBar(bool: true)
        
    }
    
    // enable and disable tabBar
    func stateTabBar (bool: Bool) {
        
        if bool == false {
            
            self.parent?.tabBarController?.tabBar.isUserInteractionEnabled = false
            
        } else {
            
            self.parent?.tabBarController?.tabBar.isUserInteractionEnabled = true
            
        }
        
    }
    
    // remove directory my movie list
    func removeDirectory() -> Bool {
        
        let path = getDirectoryPath()
        
        //    for var i in 0...100000 {
        //           i += 1
        //           print(i)
        //     }
        
        do {
            
            if removeAllData() == true {
                
                let fileManager = FileManager.default
                try fileManager.removeItem(atPath: path)
                return true
                
                //                if  self.removeAllData() == true {
                //                    return true
                //                } else {
                //                    return false
                //                }
                
            } else {
                return false
            }
            
        } catch {
            
            return false
        }
    }
    
    // change image and title buttoms
    func changeImageAndTitleButtom(selectNumber: Int, flag: Bool) {
        
        if flag != true {
            
            backUpBtn.setBackgroundImage(UIImage(named:"gray_Backup_Database-128.png"), for: UIControlState.normal)
            restoreBackUpBtn.setBackgroundImage(UIImage(named: "gray_Restore_Database-128.png"), for: UIControlState.normal)
            removeBackUpImageBtn.setBackgroundImage(UIImage(named: "gray_Delete_Database-128.png"), for: UIControlState.normal)
            
            self.backUpBtn.setTitle("Backup", for: .normal)
            self.restoreBackUpBtn.setTitle("Restore", for: .normal)
            self.removeBackUpImageBtn.setTitle("Remove", for: .normal)
            
            self.backUpBtn.isEnabled = true
            self.restoreBackUpBtn.isEnabled = true
            self.removeBackUpImageBtn.isEnabled = true
            
            let colorGray = UIColor(red: 95/255, green: 97/255, blue: 96/255, alpha: 1.0)
            
            backUpBtn.setTitleColor(colorGray, for: UIControlState.normal)
            restoreBackUpBtn.setTitleColor(colorGray, for: UIControlState.normal)
            removeBackUpImageBtn.setTitleColor(colorGray, for: UIControlState.normal)
            
        } else {
            
            let colorYellow = UIColor(red: 253/255, green: 212/255, blue: 121/255, alpha: 1.0)
            
            switch selectNumber {
                
            case 0 :
                
                self.backUpBtn.setTitle("Stop Backup", for: .normal)
                self.backUpBtn.isEnabled = true
                self.restoreBackUpBtn.isEnabled = false
                self.removeBackUpImageBtn.isEnabled = false
                
                backUpBtn.setTitleColor(colorYellow, for: UIControlState.normal)
                backUpBtn.setBackgroundImage(UIImage(named:"yellow_Backup_Database_128.png"), for: UIControlState.normal)
                
            case 1 :
                
                
             restoreBackUpBtn.setBackgroundImage(UIImage(named:"yellow_Restore_Database-128.png"), for: UIControlState.normal)
                restoreBackUpBtn.setTitle("Stop Restore", for: UIControlState.normal)
                restoreBackUpBtn.setTitleColor(colorYellow, for: UIControlState.normal)
                
                self.backUpBtn.isEnabled = false
                self.restoreBackUpBtn.isEnabled = true
                self.removeBackUpImageBtn.isEnabled = false
                
            case 2:
                
            removeBackUpImageBtn.setBackgroundImage(UIImage(named:"yellow_Remove_Database-128.png"), for: UIControlState.normal)
                removeBackUpImageBtn.setTitle("Stop Remove", for: UIControlState.normal)
                removeBackUpImageBtn.setTitleColor(colorYellow, for: UIControlState.normal)
                
                self.backUpBtn.isEnabled = false
                self.restoreBackUpBtn.isEnabled = false
                self.removeBackUpImageBtn.isEnabled = true
                
            default:
                return
                
            }
            
        }
        
    }
}
