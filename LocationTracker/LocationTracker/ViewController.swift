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
    var urlStringArray :[String] = []
    private var counter : Int = 0
    private var photosFromApi: Welcome
    private var locationManager: CLLocationManager
    var startLocation: CLLocation!
    
    @IBOutlet var collectionview: UICollectionView!
    
    @IBAction func GetStartPoint(_ sender: Any)  {
        print("okey")
        start()
      
    }
    func start(){
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        
    }
    
    @IBAction func Stop(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        urlStringArray.removeAll()
        collectionview.reloadData()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.photosFromApi = Welcome(page : 0, perPage: 0,photos : [], nextPage : "", prevPage: "")
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        super.init(coder: aDecoder)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        // load the photosFromApi
        getphotos()
        
        print("after init")
        print(self.photosFromApi.photos.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        startLocation = nil
        print("after getSubjects")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let latestLocation: CLLocation = locations[locations.count - 1]
        if startLocation == nil {
            startLocation = latestLocation
        }
       
        let distanceBetween: CLLocationDistance =
            latestLocation.distance(from: startLocation)
        
        if distanceBetween >= 100 {
            print("I am here")
            print(" The Distance is: \( distanceBetween) meters")
            startLocation  = nil
            let url = photosFromApi.photos[counter].src.small
            urlStringArray.append(url)
            collectionview.reloadData()
            counter+=1
            print(counter)
            if counter >= 15 {
                counter = 0
                print("counter has been reset")
            }
        }
    }
  
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
//                    self?.collectionview.reloadData()
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
        return urlStringArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PexelsCollectionViewCell
        let urlString = urlStringArray[indexPath.row]
        let url = URL(string:urlString)
        cell.imageView.kf.setImage(with: url)
        return cell
        
    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("inside collecttion view 2")
//        print(self.photosFromApi.photos.count)
//
//        return self.photosFromApi.photos.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("inside collecttion view 1")
//        print(self.photosFromApi.photos.count)
//
//        let photocell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PexelsCollectionViewCell
//        //
//        if (counter == photosFromApi.photos.count ){
//            counter = 0
//
//        }
//        //         let myphotos = photosFromApi.photos[counter]
//        let myphotos = photosFromApi.photos[indexPath.row]
//        //let imageArray :[UIImage] = [photos]
//        let url = URL(string:myphotos.src.small)
//        photocell.imageView.kf.setImage(with: url)
//        var  imagesArray  = [url]
//
//        //imagesArray.append(url)
//        return photocell
//
//    }
    
}


















