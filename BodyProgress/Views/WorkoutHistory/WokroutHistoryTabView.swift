//
//  WokroutHistoryTabView.swift
//  BodyProgress
//
//  Created by Karthick Selvaraj on 17/05/20.
//  Copyright © 2020 Mallow Technologies Private Limited. All rights reserved.
//

import SwiftUI

enum WorkoutHistoryStatusSort: String, CaseIterable {
    case Completed
    case Pending
    case Both
    
    func title() -> String {
        switch self {
        case .Completed:
            return "Completed 😈"
        case .Pending:
            return "Gave up 🤕"
        case .Both:
            return "All"
        }
    }
}

struct WokroutHistoryTabView: View {
    
    @State private var shouldPresentBodyParts = false
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        NavigationView {
            VStack {
                if shouldPresentBodyParts {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(BodyParts.allCases, id: \.self) { part in
                                Text(part.rawValue)
                                    .font(kPrimaryFootnoteFont)
                                    .opacity(1)
                                    .padding()
                                    .background(self.appSettings.historySelectedBodyParts.contains(part) ? self.appSettings.themeColorView() : kPrimaryBackgroundColour)
                                    .foregroundColor(.white)
                                    .frame(height: 30)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        if self.appSettings.historySelectedBodyParts.contains(part) {
                                            if let index = self.appSettings.historySelectedBodyParts.firstIndex(of: part) {
                                                self.appSettings.historySelectedBodyParts.remove(at: index)
                                                self.appSettings.historySelectedBodyParts = self.appSettings.historySelectedBodyParts
                                            }
                                        } else {
                                            self.appSettings.historySelectedBodyParts.append(part)
                                            self.appSettings.historySelectedBodyParts = self.appSettings.historySelectedBodyParts
                                        }
                                }
                            }
                        }
                    }
                    .padding([.leading, .trailing], 15)
                    Divider()
                        .padding([.leading, .trailing], 15)
                    Picker(selection: $appSettings.historySelectedCompletionStatus, label: Text("Status")) {
                        ForEach(WorkoutHistoryStatusSort.allCases, id: \.self) { status in
                            Text(status.title())
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing], 15)
                    Divider()
                        .padding([.leading, .trailing], 15)
                }
                
                WorkoutHistoryView(predicate: self.predicate(), sortDescriptor: NSSortDescriptor(keyPath: \WorkoutHistory.createdAt, ascending: false))
            }
            .navigationBarItems(leading:
                NavigationLink(destination: SummaryView(), label: {
                    Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                        .foregroundColor(appSettings.themeColorView())
                        .frame(width: 30, height: 30)
                })
                ,trailing:
                Button(action: {
                    withAnimation(.linear) {
                        self.shouldPresentBodyParts.toggle()
                    }
                }) {
                    Text(shouldPresentBodyParts ? "Done" : "Filter")
                        .font(kPrimaryBodyFont)
                        .bold()
                }
            )
        }
    }
    
    /**Creates predicate based on filter values*/
    func predicate() -> NSPredicate? {
        var predicates: [NSPredicate] = []
        predicates.append(NSPredicate(format: "bodyPart IN %@", appSettings.historySelectedBodyParts.map { $0.rawValue }))
        if appSettings.historySelectedCompletionStatus != .Both {
            predicates.append(NSPredicate(format: "status == %@", appSettings.historySelectedCompletionStatus == .Completed ? NSNumber(booleanLiteral: true) : NSNumber(booleanLiteral: false)))
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    
}

struct WokroutHistoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        WokroutHistoryTabView()
    }
}
