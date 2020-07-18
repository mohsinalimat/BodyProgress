//
//  BodyPartSummaryRow.swift
//  BodyProgress
//
//  Created by Karthick Selvaraj on 13/07/20.
//  Copyright © 2020 Mallow Technologies Private Limited. All rights reserved.
//

import SwiftUI

struct BodyPartSummaryRow: View {
    
    @EnvironmentObject var appSettings: AppSettings
    
    var summary: (sum: Double, min: Double, max: Double, average: Double, count: Double, workout: String)
    var bodyPart: BodyParts
    var total: Double
    var shouldShowDetails: Bool
    
    var percentage: Double {
        summary.sum / total * 100.0
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 5) {
                Text("\(self.summary.workout)")
                    .font(kPrimaryBodyFont)
                    .bold()
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12.5)
                                .fill(Color.black.opacity(0.1))
                                .frame(width: geo.size.width, height: 25)
                            RoundedRectangle(cornerRadius: 12.5)
                                .fill(self.appSettings.themeColorView())
                                .frame(width: (geo.size.width / 100) * CGFloat(self.percentage), height: 25)
                                .overlay(
                                    Text("\(self.percentage, specifier: "%0.2f") %")
                                    .font(kPrimaryFootnoteFont)
                                    .foregroundColor(.white)
                                    .padding([.leading, .trailing], 5)
                                    , alignment: .trailing)
                        }
                    }
                    if self.shouldShowDetails {
                        Group {
                            HStack {
                                Text("Total: \(self.summary.sum.detailedDisplayDuration())")
                                    .modifier(SummaryModifier(geo: geo))
                                Spacer()
                                Text("Sessions: \(Int(self.summary.count))")
                                    .modifier(SummaryModifier(geo: geo))
                            }
                            HStack {
                                Text("Min: \(self.summary.min.detailedDisplayDuration())")
                                    .modifier(SummaryModifier(geo: geo))
                                Spacer()
                                Text("Max: \(self.summary.max.detailedDisplayDuration())")
                                    .modifier(SummaryModifier(geo: geo))
                            }
                            HStack {
                                Text("Avg. session duration: \(self.summary.average.detailedDisplayDuration())")
                                    .frame(width: geo.size.width, height: 25)
                                    .font(kPrimaryFootnoteFont)
                                    .background(Color.black.opacity(0.1))
                                    .foregroundColor(Color.black.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                }
            }
        }
        .frame(height: shouldShowDetails ? 150 : 50)
    }
}

struct BodyPartSummaryRow_Previews: PreviewProvider {
    static var previews: some View {
        BodyPartSummaryRow(summary: (3600, 120, 3480, 360, 10, "Biceps"), bodyPart: .arms, total: 7200, shouldShowDetails: false).environmentObject(AppSettings())
    }
}

struct SummaryModifier: ViewModifier {
    
    var geo: GeometryProxy
    
    func body(content: Content) -> some View {
        content
            .font(kPrimaryFootnoteFont)
            .frame(width: geo.size.width / 2 - 5, height: 25)
            .background(Color.black.opacity(0.1))
            .foregroundColor(Color.black.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}