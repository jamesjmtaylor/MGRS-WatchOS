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
            Text(vm.lat)
            Text(vm.long)
        }.onAppear {
            self.vm.listenForLocationChanges()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatesView(vm: CoordinatesViewModel())
    }
}
