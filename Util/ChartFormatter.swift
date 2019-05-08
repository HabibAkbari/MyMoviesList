//
//  ChartFormatter.swift
//  My Movies List
//
//  Created by Habib Akbari on 7/18/18.
//  Copyright © 2018 Habib Akbari. All rights reserved.
//

import Foundation
import UIKit
import Charts

// Variable Objective-C
@objc(ChartFormatter)

class ChartFormatter: NSObject, IAxisValueFormatter {
    
    let typeChart = ["All","English","Persian","Movie","Series","View"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        //axis?.axisLineColor = UIColor.blue
        return typeChart[Int(value)]
    }

}
