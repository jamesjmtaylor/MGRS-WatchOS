//
//  HostingController.swift
//  MGRS-WatchOS WatchKit Extension
//
//  Created by James Taylor on 3/14/20.
//  Copyright © 2020 James Taylor. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<CoordinatesView> {
    override var body: CoordinatesView {
        return CoordinatesView(vm: CoordinatesViewModel())
    }
}
