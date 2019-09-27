//
//  ViewController.swift
//  Happn Weather
//
//  Created by Aymen Ben Romdhane on 24/09/2019.
//  Copyright © 2019 Aymen Ben Romdhane. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    var refreshControl: UIRefreshControl?
    var collection: [[Weather]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        setup()
    }
    func setup() {
        weatherTableView.rowHeight = 180
        weatherTableView.backgroundColor = .clear
        downloadData()

    }
    
    func reloadData() {
        refreshControl?.endRefreshing()
        collection = State.sharedInstance.groupedWeatherSamples()
        weatherTableView.reloadData()
    }
    
    func initRefreshControl(mainVC: ViewController) {
        if (refreshControl == nil) {
            refreshControl = UIRefreshControl()
            refreshControl?.addTarget(mainVC, action: #selector(ViewController.tableViewRefreshRequested), for: UIControl.Event.valueChanged)
            weatherTableView.addSubview(refreshControl!)
        }
    }
    
    @objc func tableViewRefreshRequested() {
        downloadData()
    }
    
    func downloadData() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Download the data from OpenWeatherMap
        ApiManager.getForecast { (status, error) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if (error == nil) {
                self.weatherTableView?.reloadData()
                self.reloadData()
                self.dateLabel.text = State.sharedInstance.weatherSamples[0].dateString(format: "dd MMMM YYYY")
                guard let tempInCelsus = State.sharedInstance.weatherSamples[0].temperatureInCelsius() else { return }
                self.temperatureLabel.text = "\(Int(tempInCelsus))°C"
                guard let mainWeather = State.sharedInstance.weatherSamples[0].weatherMain else { return }
                switch mainWeather {
                    case "Clouds": self.weatherImageView.image = UIImage(named: "Clouds")
                    case "Clear" : self.weatherImageView.image = UIImage(named: "Clear")
                    case "Rain" : self.weatherImageView.image = UIImage(named: "Rain")
                    default:
                        self.weatherImageView.image = UIImage(named: "Clear")
                }
                
            } else {
                
                // If there's an error, let's display the message here
                let alert = UIAlertController()
                alert.title = "Check your API Key & Network!"
                alert.message = error?.localizedDescription
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (alertAction) -> Void in
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }

}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyWeatherCell
        
        let weatherSamples = collection[indexPath.row]
        cell.setWeatherSamples(weatherSamples: weatherSamples)
        
        return cell
    }
}
