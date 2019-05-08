//
//  ChartMoviesListViewController.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/18/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import UIKit
import Charts
import CoreData


class ChartMoviesListViewController: UIViewController {

 
    // MARK: - IBOutlet
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var scrollingView: UIScrollView!
    
    // MARK: - var & let
    var movieList = [MyMoviesList]()
    let typeChart = ["All","English","Persian","Movie","Series","View"]
    var countChart = [Int]()
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setImageBackgroundNavgtionBar()

        
        // scrolling
        scrollingView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
        backgroundImageView.addBlurEffect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchResults()
        setChart(dataPoint: typeChart, values: countChart)
        
    }
    
    // MARK: - Func
    func setChart(dataPoint: [String], values:[Int]) {
        
        let chartFormatter = ChartFormatter()
        let xaxis = XAxis()
        var dataEntries = [ChartDataEntry]()
        
        for item in 0..<dataPoint.count {
            
            let dataEntiry = BarChartDataEntry(x: Double(item), y: Double(values[item]))
            dataEntries.append(dataEntiry)
            
        }
        
        xaxis.valueFormatter = chartFormatter
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.valueColors = [UIColor.white]
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.xAxis.valueFormatter = xaxis.valueFormatter
        barChartView.xAxis.labelTextColor = UIColor.white
        barChartView.xAxis.labelFont = UIFont(name: "Helvetica Neue", size: 12)!
        barChartView.leftAxis.labelTextColor = UIColor.white
        barChartView.rightAxis.labelTextColor = UIColor.white
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        barChartView.backgroundColor = UIColor.clear
        barChartView.chartDescription?.text = "Movies List"
        barChartView.chartDescription?.textColor = UIColor.white
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInCubic)
        barChartView.data = chartData
        
    }
    
    func fetchResults() {
        
        let appApplication = UIApplication.shared.delegate as! AppDelegate
        let context = appApplication.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyMoviesList")
        
        do {
            let results = try context.fetch(fetchRequest)
            self.movieList = results as! [MyMoviesList]
            
        } catch {
            
            let alert = alertMe(title: "Error", message: "Can not load data", value: 100)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        process()
        
    }
    
    func process()  {
        
        let countMovie = movieList.count
        var otherlanguage = Int()
        var originalLanuage = Int()
        var persianLangehe = Int()
        var movieCount = Int()
        var seriesCount = Int()
        var viewCount = Int()
        
        for item in movieList {
            
            let language = item.language?.components(separatedBy: ",")
            
            for itemLanguage in language! {
                
                if itemLanguage == " Persian" {
                    
                    persianLangehe += 1
                    otherlanguage += 1
                    
                    break
                    
                } else {
                    
                    otherlanguage += 1
                    
                }
            }
            
            if otherlanguage >= 1 {
                
                originalLanuage += 1
            }
            
            if item.view == true {
                viewCount += 1
            }
            
            if item.type == "movie" {
                
                movieCount += 1
                
            } else {
                
                seriesCount += 1
            }
            
        }
        
        countChart = [countMovie,originalLanuage,persianLangehe,movieCount,seriesCount,viewCount]
        
    }
    
}
