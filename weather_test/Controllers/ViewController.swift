//
//  ViewController.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var sunsetValueLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseValueLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var minLabelValue: UILabel!
    @IBOutlet weak var maxLabelValue: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var afterSearchBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstSearchBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var root: RootClass?{
        didSet{
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        localize()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.view.endEditing(true)
        search()
    }

    // MARK: - Functions
    
    func localize(){
        searchBar.placeholder = NSLocalizedString("search bar", comment: "")
        sunriseLabel.text = NSLocalizedString("sunrise", comment: "")
        sunsetLabel.text = NSLocalizedString("sunset", comment: "")
        mapButton.setTitle(NSLocalizedString("map button", comment: ""), for: .normal)
    }
    
    func search(){
        let params = [
            "q":searchBar.text,
            "apikey":Config.apiKey,
            ]
        
        Api.cityRequest(params: params as [String : AnyObject], completion:  { (result) in
            switch result{
            case .Success(let response):
                print(response)
                DispatchQueue.once(token: self.token) {
                    self.setNewContraints()
                }
                let rootObject = RootClass(fromJson: response)
                self.root = rootObject
                break
            case .Error(let errorResponse):
                print(errorResponse)
                self.displayError(string: errorResponse["message"].stringValue)
                break
            case .Failure(let error):
                print(error)
                break
            }
            
        })
    }
    
    func setNewContraints(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                if let firstConstr = self.firstSearchBarConstraint{
                firstConstr.isActive = false
                self.afterSearchBarConstraint.isActive = true
                self.view.layoutIfNeeded()
                }
            })
        }
    }
    
    @objc func updateUI(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: {
                self.updateBackground()
                self.calcDate()
                self.setVisible(labels: self.descriptionLabel, self.cityLabel, self.tempLabel, self.maxLabel, self.maxLabelValue, self.minLabel, self.minLabelValue, self.sunriseLabel, self.sunriseValueLabel, self.sunsetLabel, self.sunsetValueLabel)
                self.mapButton.alpha = 1
                self.cityLabel.text = self.root?.name
                self.tempLabel.text = String(Int((self.root?.main.temp)!)) + "°C"
                self.descriptionLabel.text = self.root?.weather[0].descriptionField
                self.minLabelValue.text = String(Int((self.root?.main.tempMin)!)) + "°C"
                self.maxLabelValue.text = String(Int((self.root?.main.tempMax)!)) + "°C"
            })
    }
}
    
    func calcDate(){
        let dateSunrise = self.root?.sys.calcSunrise()
        let dateSunset = self.root?.sys.calcSunset()
        let timestampSunrise = DateFormatter.localizedString(from: dateSunrise!, dateStyle: .short, timeStyle: .short)
        let timestampSunset = DateFormatter.localizedString(from: dateSunset!, dateStyle: .short, timeStyle: .short)
        self.sunriseValueLabel.text = timestampSunrise
        self.sunsetValueLabel.text = timestampSunset
    }
    
    func updateBackground(){
        let codeBackground = self.root?.codeBackground()
        switch codeBackground{
        case 800?:
            self.background.image = UIImage(named: "Sun")
            break
        case _ where codeBackground! > 800 && codeBackground! < 900:
            self.background.image = UIImage(named: "Windy")
            break
        case _ where codeBackground! > 200 && codeBackground! < 600:
            self.background.image = UIImage(named: "Storm")
            break
        case _ where codeBackground! > 600 && codeBackground! < 700:
            self.background.image = UIImage(named: "Snow")
            break
        default: break
        }
    }
    
    func prepareCoordinates()->CLLocationCoordinate2D{
        let location = CLLocation(latitude: Double((self.root?.coord.lat)!), longitude: Double((self.root?.coord.lon)!))
        return location.coordinate
    }
    
    // MARK: - Actions
    @IBAction func viewMapAction(_ sender: Any) {
        let coordinates = self.prepareCoordinates()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mapsVC") as! MapViewController
        vc.coordinates = [coordinates]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

