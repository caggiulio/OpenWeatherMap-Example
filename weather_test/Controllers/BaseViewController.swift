//
//  BaseViewController.swift
//  weather_test
//
//  Created by nunzio giulio caggegi on 20/11/17.
//  Copyright © 2017 nunzio giulio caggegi. All rights reserved.
//

import UIKit
import MapKit

class BaseViewController: UIViewController, MKMapViewDelegate {
    
    let token = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayError(string: String){
        UIView.animate(withDuration: 0.6, animations: {
            DispatchQueue.main.async(execute: {
                let alertController = UIAlertController(title: "Errore", message: string, preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            })
        })
    }
    
    func setVisible(labels: UILabel...){
        for label in labels{
            label.alpha = 1
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

public extension DispatchQueue {
    
    private static var onceTokens = [Int]()
    private static var internalQueue = DispatchQueue(label: "dispatchqueue.once")
    
    public class func once(token: Int, closure: ()->Void) {
        internalQueue.sync {
            if onceTokens.contains(token) {
                return
            }else{
                onceTokens.append(token)
            }
            closure()
        }
    }
}


