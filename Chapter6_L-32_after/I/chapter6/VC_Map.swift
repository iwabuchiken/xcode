//
//  VC_Map.swift
//  Chapter6
//
//  Created by mac on 2016/03/08.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

//from --> Katou.L-46
class VC_Map : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinButton: UIButton!
    
    let locationManager = CLLocationManager()
    var lastLocation:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] viewDidLoad")
        
        locationManager.delegate = self
        
        // 100m 移動したら位置情報を更新する
        locationManager.distanceFilter = 100.0
        
        // 測位の精度を 100ｍ とする
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // 位置情報サービスへの認証状態を取得する
        let status = CLLocationManager.authorizationStatus()
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] status.rawValue => \(status.rawValue)")
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] CLAuthorizationStatus.NotDetermined => \(CLAuthorizationStatus.NotDetermined.rawValue)")
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] status == CLAuthorizationStatus.NotDetermined => \(status == CLAuthorizationStatus.NotDetermined)")
        
        
        if status == CLAuthorizationStatus.NotDetermined {

            //debug
            print("[\(Methods.basename(#file)):\(#line)] starting... => request dialog")

            // 未認証ならリクエストダイアログ出す
            locationManager.requestWhenInUseAuthorization();
        }
        
        //debug
        print("[\(Methods.basename(#file)):\(#line)] starting... => locationManager")

        
        // 位置情報の取得を開始させる
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // show num of locs
        self._viewWillAppear__Show_NumOf_Locs()
        
    }

    func _viewWillAppear__Show_NumOf_Locs() {

        let locs = Proj.find_All_Locs()

        //debug
        print("[\(Methods.basename(#file)):\(#line)] locs.count => \(locs.count)")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushedButton(sender: UIButton) {
        
        // 最後に取得した位置情報で CLLocationCoordinate2D を作成する
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation!.latitude, lastLocation!.longitude)
        

        //debug
        print("[\(Methods.basename(#file)):\(#line)] lastLocation!.latitude... => \(lastLocation!.latitude)")

        //debug
        print("[\(Methods.basename(#file)):\(#line)] lastLocation!.latitude + 10 => \(lastLocation!.latitude + 10)")

        //debug
        print("[\(Methods.basename(#file)):\(#line)] Double(lastLocation!.latitude) => \(Double(lastLocation!.latitude))")
        
//        //debug
//        print("[\(Methods.basename(#file)):\(#line)] lastLocation!.latitude.value => \(lastLocation!.latitude.value)")

        //debug
        print("[\(Methods.basename(#file)):\(#line)] lastLocation!.latitude.description => \(lastLocation!.latitude.description)")

        // 地図のセンターに設定する
        mapView.setCenterCoordinate(center, animated: true)
        
        // ピン（MKPointAnnotation）を作成する
        let pin: MKPointAnnotation = MKPointAnnotation()
        
        // 最後に取得した位置情報を設定する
        pin.coordinate = center
        
        // 地図にピンを立てる
        mapView.addAnnotation(pin)
        
        
        // save data
        let time_label = Methods.get_TimeLable()
        
//        Proj.save_Loc(center)
        Proj.save_Loc(center, time_label: time_label)
        
        
        // save diary
        self._pushedButton__SaveDiary(center, time_label: time_label);
    
    
    }
    
    /*
        @return
        -1      can't save
        0       preference --> not save diary
        1       saved
    */
    func _pushedButton__SaveDiary
    (loc : CLLocationCoordinate2D, time_label : String) -> Int {
        
        // judge -> pref value
        let pref = Methods.getDefaults_Boolean(CONS.defaultKeys.key_Default_Add_LocationDiary)
        
        if (pref == true) {

            let title = "@loc"
            
//            let memo = "\(Methods.get_TimeLable())\nlongi=\(Double(loc.longitude.description)!)\nlat=\(Double(loc.latitude.description)!)\n"
            let memo = "\(time_label)\nlongi=\(Double(loc.longitude.description)!)\nlat=\(Double(loc.latitude.description)!)\n"
            
            let res_i = Proj.save_Diary(title, memo: memo)
            
            //debug
            print("[\(Methods.basename(#file)):\(#line)] 'save_Diary() result => \(res_i) --> '\(title)' / '\(memo)'")

            
        } else {

            //debug
            print("[\(Methods.basename(#file)):\(#line)] pref set to => false")

            return 0
            
        }
        
        // return
        return -1
        
    }
    
    // 位置情報が更新された時に呼ばれる
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 位置情報の配列から一番最後に取得した位置情報の緯度経度（coordinate）を取り出す
        let locations: NSArray = locations as NSArray
        let location: CLLocation = locations.lastObject as! CLLocation
        lastLocation = location.coordinate
        
        
        
        if let location = lastLocation {
            
            // 最後に取得した位置情報で CLLocationCoordinate2D を作成する
            let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation!.latitude, lastLocation!.longitude)
            
            // 地図のセンターに設定する
            mapView.setCenterCoordinate(center, animated: true)
            
            // 現在地から 5km 四方で表示させる
            let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, 5000, 5000)
            mapView.setRegion(region, animated: true)
            
            pinButton.enabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status{
        case CLAuthorizationStatus.AuthorizedWhenInUse:
            // 位置情報の取得を開始させる
            locationManager.startUpdatingLocation()
        case CLAuthorizationStatus.AuthorizedAlways:
            // 位置情報の取得を開始させる
            locationManager.startUpdatingLocation()
        case CLAuthorizationStatus.Denied:
            print("Denied")
        case CLAuthorizationStatus.Restricted:
            print("Restricted")
        case CLAuthorizationStatus.NotDetermined:
            print("NotDetermined")
        }
    }
}

