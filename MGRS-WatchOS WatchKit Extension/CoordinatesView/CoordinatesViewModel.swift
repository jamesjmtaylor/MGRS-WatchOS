//
//  CoordinatesViewModel.swift
//  MGRS-WatchOS WatchKit Extension
//
//  Created by James Taylor on 3/15/20.
//  Copyright © 2020 James Taylor. All rights reserved.
//

import Foundation
import WatchKit
import Combine
import CoreLocation

class CoordinatesViewModel: ObservableObject {
    private let appDel = WKExtension.shared().delegate as? ExtensionDelegate
    private let dateFormatter = DateFormatter()
    private var lastLocation : CLLocation? = nil
    @Published var coordinateString = "Fetching..."
    @Published var dtgString = "Last update: -"//"Last Update: 2020-03-05 17:32+1000"
    @Published var accuracyString = "Accuracy: -"
    @Published var coordinateSystem = CoordinateSystem.MGRS

    func changeCoordinateSystem(){
        switch coordinateSystem {
            case .MGRS: coordinateSystem = .LATLONG; updateCoordinateString(lastLocation)
            case .LATLONG: coordinateSystem = .UTM; updateCoordinateString(lastLocation)
            case .UTM: coordinateSystem = .MGRS; updateCoordinateString(lastLocation)
        }
    }

    func initDateFormatter(){
        dateFormatter.dateFormat = "y-MM-dd HH:mmZ"
    }

    func listenForLocationChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)),
                                               name: appDel?.LOCATION_CHANGED, object: nil)
    }

    fileprivate func updateCoordinateString(_ location: CLLocation?) {
        guard let location = location else {return}
        switch coordinateSystem {
            case .MGRS:
                coordinateString = GeoCoordinateConverter
                    .shared()?
                    .mgrs(fromLatitude: location.coordinate.latitude,
                          longitude: location.coordinate.longitude)?
                    .description ?? coordinateString
            case .UTM:
                coordinateString = GeoCoordinateConverter
                    .shared()?
                    .utm(fromLatitude: location.coordinate.latitude,
                         longitude: location.coordinate.longitude)?
                    .description ?? coordinateString
            case .LATLONG:
                coordinateString = "\(location.coordinate.latitude.rounded(toPlaces: 5)), \(location.coordinate.longitude.rounded(toPlaces: 5))"
        }
    }

    @objc private func handleNotification(notification: NSNotification){
        lastLocation = notification.object as? CLLocation
        guard let location = lastLocation else { return }
        dtgString = "Last update:\n \(dateFormatter.string(from: Date()))"
        accuracyString = "Accuracy: +/- \(Int(location.horizontalAccuracy))m"
        updateCoordinateString(location)
    }
}

enum CoordinateSystem: String { case MGRS, UTM, LATLONG }
