//
//  Fonts.swift
//  NYTimes-Most-Popular-Challenge
//
//  Created by Jeremias on 29/11/2024.
//

import SwiftUI

enum Fonts {
    
    enum Sizes: CGFloat {
        case title = 25
        case subtitle = 20
        case regular = 16
        case reading = 13
        case small = 10
    }
    
    case sanFrancisco
    case sanFranciscoRounded
    case sanFranciscoMonospaced
    case newYorkSerif
    case sfCompact
    case chalkboard
    case markerFelt
    case avenir
    case courier
    case helveticaNeue
    case annaiMn
    case timesNewRoman

    func font(size: Sizes = Sizes.regular) -> Font {
        switch self {
        case .sanFrancisco:
            return .system(size: size.rawValue)
        case .sanFranciscoRounded:
            return .system(size: size.rawValue, design: .rounded)
        case .sanFranciscoMonospaced:
            return .system(size: size.rawValue, design: .monospaced)
        case .newYorkSerif:
            return .system(size: size.rawValue, design: .serif)
        case .sfCompact:
            return .custom("SFCompactText-Regular", size: size.rawValue)
        case .chalkboard:
            return .custom("ChalkboardSE-Regular", size: size.rawValue)
        case .markerFelt:
            return .custom("MarkerFelt-Wide", size: size.rawValue)
        case .avenir:
            return .custom("Avenir-Book", size: size.rawValue)
        case .courier:
            return .custom("Courier", size: size.rawValue)
        case .helveticaNeue:
            return .custom("HelveticaNeue", size: size.rawValue)
        case .annaiMn:
            return .custom("Annai-MN", size: size.rawValue)
        case .timesNewRoman:
            return .custom("TimesNewRomanPSMT", size: size.rawValue)
        }
    }
}

struct FontSamplesView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 5) {
                Text("San Francisco - System Font")
                    .font(Fonts.sanFrancisco.font(size: .subtitle))
                    .padding()

                Text("San Francisco Rounded")
                    .font(Fonts.sanFranciscoRounded.font(size: .subtitle))
                    .padding()

                Text("San Francisco Monospaced")
                    .font(Fonts.sanFranciscoMonospaced.font(size: .subtitle))
                    .padding()

                Text("New York Serif")
                    .font(Fonts.newYorkSerif.font(size: .subtitle))
                    .padding()

                Text("SF Compact")
                    .font(Fonts.sfCompact.font(size: .subtitle))
                    .padding()

                Text("Chalkboard SE")
                    .font(Fonts.chalkboard.font(size: .subtitle))
                    .padding()

                Text("Marker Felt")
                    .font(Fonts.markerFelt.font(size: .subtitle))
                    .padding()

                Text("Avenir")
                    .font(Fonts.avenir.font(size: .subtitle))
                    .padding()

                Text("Courier")
                    .font(Fonts.courier.font(size: .subtitle))
                    .padding()

                Text("Helvetica Neue")
                    .font(Fonts.helveticaNeue.font(size: .subtitle))
                    .padding()
                
                Text("Annai MN")
                    .font(Fonts.annaiMn.font(size: .subtitle))
                    .padding()
                
                Text("Times New Roman")
                    .font(Fonts.newYorkSerif.font(size: .subtitle))
                    .padding()
            }
            .padding()
        }
    }
}

struct FontShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        FontSamplesView()
    }
}
