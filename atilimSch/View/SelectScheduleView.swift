//
//  SelectScheduleView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct SelectScheduleView: View {
    @State private var selectedView = 1

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select View", selection: $selectedView) {
                    Text("Weekly").tag(0)
                    Text("Daily").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                if selectedView == 0 {
                    ScheduleResultView()
                } else {
                    ScheduleView()
                }
            }
        }
    }
}

#Preview {
    SelectScheduleView()
}
