//
//  XKCD_WidgetLiveActivity.swift
//  XKCD_Widget
//
//  Created by Sam Jin on 3/25/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct XKCD_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct XKCD_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: XKCD_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension XKCD_WidgetAttributes {
    fileprivate static var preview: XKCD_WidgetAttributes {
        XKCD_WidgetAttributes(name: "World")
    }
}

extension XKCD_WidgetAttributes.ContentState {
    fileprivate static var smiley: XKCD_WidgetAttributes.ContentState {
        XKCD_WidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: XKCD_WidgetAttributes.ContentState {
         XKCD_WidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: XKCD_WidgetAttributes.preview) {
   XKCD_WidgetLiveActivity()
} contentStates: {
    XKCD_WidgetAttributes.ContentState.smiley
    XKCD_WidgetAttributes.ContentState.starEyes
}
