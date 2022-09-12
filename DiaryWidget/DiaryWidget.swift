//
//  DiaryWidget.swift
//  DiaryWidget
//
//  Created by 강조은 on 2022/09/12.
//

import WidgetKit
import SwiftUI
import Intents
import UIKit

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    var csvData: [String] = []
    var tmpString: String = ""
}

struct DiaryWidgetEntryView : View {
    var tmpStringg: String = "test"
    var entry: Provider.Entry
    var body: some View {
      ZStack {
          Color("mainColor")
          .ignoresSafeArea()
        Text(tmpStringg)
              .font(Font.custom("KOTRA_GOTHIC", size: 15))
      }
    }
    mutating func test() {
        self.tmpStringg = "test..."
    }
}

@main
struct DiaryWidget: Widget {
    let kind: String = "DiaryWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DiaryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("감사 일기 위젯")
        .description("랜덤으로 글귀를 제공합니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct DiaryWidget_Previews: PreviewProvider {
    static var previews: some View {
        DiaryWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

