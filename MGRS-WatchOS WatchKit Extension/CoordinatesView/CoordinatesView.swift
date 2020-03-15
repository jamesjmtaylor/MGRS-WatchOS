//
//  ContentView.swift
//  MGRS-WatchOS WatchKit Extension
//
//  Created by James Taylor on 3/14/20.
//  Copyright © 2020 James Taylor. All rights reserved.
//

import SwiftUI

struct CoordinatesView: View {
    @ObservedObject var vm: CoordinatesViewModel

    var body: some View {
        VStack {
            Text(vm.coordinateString)
            Text(vm.dtgString)
                .fixedSize(horizontal: false, vertical: true)
            Text(vm.accuracyString)
            Button(action: vm.changeCoordinateSystem) {
                Text(vm.coordinateSystem.rawValue)
            }
        }.onAppear {
            self.vm.listenForLocationChanges()
            self.vm.initDateFormatter()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatesView(vm: CoordinatesViewModel())
    }
}
