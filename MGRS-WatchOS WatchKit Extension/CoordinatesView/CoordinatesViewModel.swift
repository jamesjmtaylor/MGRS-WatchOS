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
    @Published var lat = "Lat"
    @Published var long = "Long"

    func listenForLocationChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notification:)),
                                               name: appDel?.LOCATION_CHANGED, object: nil)
    }

    @objc private func handleNotification(notification: NSNotification){
        guard let loc = notification.object as? CLLocation else { return }
        //lat = loc.coordinate.latitude.description
        //long = loc.coordinate.longitude.description
        lat = GeoCoordinateConverter.shared()?.mgrs(fromLatitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)?.description ?? "MGRS"
    }
}
