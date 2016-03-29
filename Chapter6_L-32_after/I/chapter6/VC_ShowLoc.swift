//
//  VC_ShowLoc.swift
//  Chapter6
//
//  Created by mac on 2016/03/29.
//  Copyright © 2016年 shoeisha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class VC_ShowLoc: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    // MARK: vars
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var lastLocation:CLLocationCoordinate2D?


    // loc
//    var loc : Loc?
    var loc : Loc = Loc()
//    var longi : Double! = 0;
//    var lat : Double! = 0;
    
    // MARK: view-related
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // setup --> map
        self._viewDidLoad()
        
    }
    
    func _viewDidLoad() {
        
        locationManager.delegate = self
        
        // 100m 移動したら位置情報を更新する
        locationManager.distanceFilter = 100.0
        
        // 測位の精度を 100ｍ とする
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // 位置情報サービスへの認証状態を取得する
        let status = CLLocationManager.authorizationStatus()
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] status.rawValue => \(status.rawValue)")
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] CLAuthorizationStatus.NotDetermined => \(CLAuthorizationStatus.NotDetermined.rawValue)")
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] status == CLAuthorizationStatus.NotDetermined => \(status == CLAuthorizationStatus.NotDetermined)")
        
        
        if status == CLAuthorizationStatus.NotDetermined {
            
            //debug
            print("[\(Methods.basename(__FILE__)):\(__LINE__)] starting... => request dialog")
            
            // 未認証ならリクエストダイアログ出す
            locationManager.requestWhenInUseAuthorization();
        }
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] starting... => locationManager")
        
        
        // 位置情報の取得を開始させる
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] map setup => done")
	
//        // default zoom
//        self._set_DefaultZoom()
        
    }
    
    func _set_DefaultZoom(center : CLLocationCoordinate2D) {
        
        //ref http://stackoverflow.com/questions/33115802/how-do-i-zoom-in-on-a-location-using-mapkit-in-swift-2-x-code "How about the following code?"
        let span = MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)

//        let coordinate = placemark.location!.coordinate
        
//        let region = MKCoordinateRegion(center: coordinate, span: span)
        let region = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] viewWillAppear")
        
        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] self.loc.description => \(self.loc.description)")
        
        
        // set pin
        self._viewWillAppear__SetPin()
        
    }

    func _viewWillAppear__SetPin() {
    
//        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lastLocation!.latitude, lastLocation!.longitude)
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(self.loc.lat.description)!, Double(self.loc.longi.description)!)
//        Double(locs[indexPath.row].longi.description)!

        //debug
        print("[\(Methods.basename(__FILE__)):\(__LINE__)] center.longitude.description => \(center.longitude.description) / center.latitude.description => \(center.latitude.description)")

        
        // 地図のセンターに設定する
        mapView.setCenterCoordinate(center, animated: true)
        
        // ピン（MKPointAnnotation）を作成する
        let pin: MKPointAnnotation = MKPointAnnotation()
        
        // 最後に取得した位置情報を設定する
        pin.coordinate = center
        
        // 地図にピンを立てる
        mapView.addAnnotation(pin)

        // zoom
        self._set_DefaultZoom(center)
        
    }
    
}
