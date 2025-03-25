//
//  XKCD_WidgetBundle.swift
//  XKCD_Widget
//
//  Created by Sam Jin on 3/25/25.
//

import WidgetKit
import SwiftUI

@main
struct XKCD_WidgetBundle: WidgetBundle {
    var body: some Widget {
        XKCD_Widget()
        XKCD_WidgetControl()
        XKCD_WidgetLiveActivity()
    }
}
