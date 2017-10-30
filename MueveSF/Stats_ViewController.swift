//
//  Stats_ViewController.swift
//  MueveSF
//
//  Created by Martín Fernández on 10/30/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit
import Charts

class Stats_ViewController: UIViewController {
    
    
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var pieChart: PieChartView!
    
    var numbers : [Double] = [1,2,3,4,4,5,6];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateGraph()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        var pieChartEntry = [ChartDataEntry]()
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
            
            let entry = PieChartDataEntry(value: Double(numbers[i]), label: "#\(i)");
            
            pieChartEntry.append(entry)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "Number") //Here we convert lineChartEntry to a LineChartDataSet
        
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        
        let data = LineChartData() //This is the object that will be added to the chart
        
        data.addDataSet(line1) //Adds the line to the dataSet
        
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        
        
        
        let dataSet = PieChartDataSet(values: pieChartEntry, label: "Widget Types")
        let data2 = PieChartData(dataSet: dataSet)
        pieChart.data = data2 
        pieChart.chartDescription?.text = "Share of Widgets by Type"
        
        //All other additions to this function will go here
        
        //This must stay at end of function
        pieChart.notifyDataSetChanged()
        
        
    }

}
