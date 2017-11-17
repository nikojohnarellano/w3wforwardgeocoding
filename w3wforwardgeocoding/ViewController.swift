//
//  ViewController.swift
//  w3wforwardgeocoding
//
//  Created by Niko Arellano on 2017-10-06.
//  Copyright © 2017 Mobilux. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var data : [String : AnyObject]?
    
    var geomLatitude : String?
    
    var geomLongitude : String?

    @IBOutlet weak var word1: UITextField!
    
    @IBOutlet weak var word2: UITextField!
    
    @IBOutlet weak var word3: UITextField!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var swLatitude: UILabel!
    
    @IBOutlet weak var neLongitude: UILabel!
    
    @IBOutlet weak var neLatitude: UILabel!
    
    @IBOutlet weak var swLongitude: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func request(_ sender: Any) {
        requestWhat3Words(word1 : word1.text!, word2 : word2.text!, word3:  word3.text!)
    
    }
    
    func requestWhat3Words(word1 : String, word2 : String, word3 : String) {
        let urlString = "https://api.what3words.com/v2/forward?addr=\(word1).\(word2).\(word3)&display=full&format=json&key=BJEVPZLZ"
        
        guard let requestUrl = URL(string:urlString) else { return }
        let request = URLRequest(url:requestUrl)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil,let usableData = data {
                let dataString = String(data: usableData, encoding: String.Encoding.utf8)
                
                self.data = self.convertJsonToDictionary(text: dataString!)
                /*
                let geometry = self.convertJsonToDictionary(text : String(data: self.data!["geometry"] as! Data, encoding: String.Encoding.utf8)!)
                let bounds   = self.convertJsonToDictionary(text: String(data: self.data!["bounds"] as! Data, encoding: String.Encoding.utf8)!)*/
                /*
                let northeast   = self.convertJsonToDictionary(text: String(data: bounds["northeast"] as! Data, encoding: String.Encoding.utf8)!)
                let southwest   = self.convertJsonToDictionary(text: String(data: bounds["southwest"] as! Data, encoding: String.Encoding.utf8)!)
                */
                
                let decoder = JSONDecoder()
                let geocode : ForwardGeocodeInfo
                do {
                    geocode = try decoder.decode(ForwardGeocodeInfo.self, from : usableData)
                    DispatchQueue.main.async {
                        self.latitude.text = "\(geocode.geometry.lat)"
                        self.longitude.text = "\(geocode.geometry.lng)"
                    }
                } catch {
                    print(error)
                }
                
                
            }
        }
        
        task.resume()
    }

    func convertJsonToDictionary(text: String) -> [String: AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String:AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}

