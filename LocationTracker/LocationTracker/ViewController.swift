//
//  ViewController.swift
//  LocationTracker
//
//  Created by Deepashri Khawase on 01.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher



class ViewController: UIViewController,CLLocationManagerDelegate {
    var imagesArray :[UIImage] = []
    
    @IBOutlet var collectionview: UICollectionView!
    
    @IBAction func GetStartPoint(_ sender: Any)  {
        print("okey")
        
        locationManager.stopUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        //locationManager.requestLocation()
        
        //locationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //       print("locations = \(locations)")
        
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        let distanceBetween: CLLocationDistance =
            latestLocation.distance(from: startLocation)
        //print(" The Distance is:\( distanceBetween) %.2f")
        
        if distanceBetween >= 100 {
            print("I am here")
            //distance.text = String(format: "%.2f", distanceBetween)
            print(" The Distance is: \( distanceBetween) meters")
            startLocation  = nil
            getphotos(  )
            counter+=1
            print(counter)
        }
        //distance.text = String(format: "%.2f", distanceBetween)
    }
    
    
    func startWhenInUse(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    private var counter : Int = 0
    
    //private var arrayofpics : [UIImage]
    private var photosFromApi: Welcome
    private var locationManager: CLLocationManager
    var startLocation: CLLocation!
    //private var listner :
    
    
    required init?(coder aDecoder: NSCoder) {
        self.photosFromApi = Welcome(page : 0, perPage: 0,photos : [], nextPage : "", prevPage: "")
        
        //
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        super.init(coder: aDecoder)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        print("after init")
        print(self.photosFromApi.photos.count)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        startLocation = nil
        
        
        
        //getphotos()
//        print("after getSubjects")
//        print(self.photosFromApi.photos.count)
        
        
    }
    
    
    
    
    
    
    
    
    /*
     imageView.kf.setImage(with: url) { result in
     switch result {
     case .success(let value):
     print("Image: \(value.image). Got from: \
     (value.cacheType)")
     case .failure(let error):
     print("Error: \(error)")
     }
     }
     
     */
    
    
    
    
    
    
    
    
    
   

    
    
    
    
    
    func getphotos() {
        
        let apiUrl = "https://api.pexels.com/v1/curated?per_page=15&page=2"
        
        guard let baseUrl = URL(string: apiUrl)
            else { return }
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        request.addValue("563492ad6f91700001000001e80b0a30b96b4593966d38568a5fbb80", forHTTPHeaderField: "Authorization")
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            let decoder = JSONDecoder()
            if let data = data,
                let serverResponse = try? decoder.decode(Welcome.self, from: data),
                let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.photosFromApi = serverResponse as Welcome
                     //imagesArray.append(url)
                    self?.collectionview.reloadData()
                    
                    //print(self?.photosFromApi.photos.count)
                }
            } else {
                print("Oh noes! error!")
            }
            
        }
        
        task.resume()
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("inside collecttion view 2")
        print(self.photosFromApi.photos.count)
        
        return self.photosFromApi.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("inside collecttion view 1")
        print(self.photosFromApi.photos.count)
        
        let photocell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PexelsCollectionViewCell
        //
        if (counter == photosFromApi.photos.count ){
            counter = 0
            
        }
         let myphotos = photosFromApi.photos[indexPath.row]
        //let myphotos = photosFromApi.photos[indexPath.row]
        //let imageArray :[UIImage] = [photos]
        let url = URL(string:myphotos.src.small)
        photocell.imageView.kf.setImage(with: url)
        var  imagesArray  = [url]
         
        //imagesArray.append(url)
            
        
        
        return photocell
        
    }
    
}



    
   
    
    
    
    
    
    
    
    
    
    



