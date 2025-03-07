//
//  FilterResultsView.swift
//  Open Wallpaper Engine
//
//  Created by Haren on 2023/6/29.
//

import SwiftUI
import Combine

enum GeneralControl {
    case all, none
}

protocol FilterResultsModel: OptionSet where Element == Self, RawValue == Int {
    static var allOptions: [String] { get }
}

struct FRShowOnly: OptionSet {
    let rawValue: Int
    
    static let allOptions = [
        ("Approved", "trophy.fill"),
        ("My Favourites", "heart.fill"),
        ("Mobile Compatible", "iphone.gen3"),
        ("Audio Responsive", ""),
        ("Customizable", "")
    ]
    
    static let approved             = FRShowOnly(rawValue: 1 << 0)
    static let myFavourites         = FRShowOnly(rawValue: 1 << 1)
    static let mobileCompatible     = FRShowOnly(rawValue: 1 << 2)
    static let audioResponsive      = FRShowOnly(rawValue: 1 << 3)
    static let customizable         = FRShowOnly(rawValue: 1 << 4)
    
    static let all: FRShowOnly = [.approved, myFavourites, mobileCompatible, .audioResponsive, .customizable]
    static let none: FRShowOnly = []
}

struct FRType: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions = [
        "Scene",
        "Video",
        "Web",
        "Application",
        "Wallpaper",
        "Preset"
    ]
    
    static let scene            = FRType(rawValue: 1 << 0)
    static let video            = FRType(rawValue: 1 << 1)
    static let web              = FRType(rawValue: 1 << 2)
    static let application      = FRType(rawValue: 1 << 3)
    static let wallpaper        = FRType(rawValue: 1 << 4)
    static let preset           = FRType(rawValue: 1 << 5)
    
    static let all: FRType      = [.scene, .video, .web, .application, .wallpaper, .preset]
    static let none: FRType     = []
}

struct FRAgeRating: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions = [
        "Everyone",
        "Partial Nudity",
        "Mature"
    ]
    
    static let everyone             = FRAgeRating(rawValue: 1 << 0)
    static let partialNudity        = FRAgeRating(rawValue: 1 << 1)
    static let mature               = FRAgeRating(rawValue: 1 << 2)
    
    static let all: FRAgeRating     = [.everyone, .partialNudity, .mature]
    static let none: FRAgeRating    = []
}

struct FRWidescreenResolution: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions = [
        "StandardDefinition",
        "1280x720",
        "1920x1080-FullHD",
        "2560x1440",
        "3840x2160-4K"
    ]
    
    static let standardDefinition   = Self.init(rawValue: 1 << 0)
    static let resolution1280x720   = Self.init(rawValue: 1 << 1)
    static let resolution1920x1080  = Self.init(rawValue: 1 << 2)
    static let resolution2560x1440  = Self.init(rawValue: 1 << 3)
    static let resolution3840x2160  = Self.init(rawValue: 1 << 4)
    
    static let all: Self            = [.standardDefinition, resolution1280x720, resolution1920x1080, .resolution2560x1440, .resolution3840x2160]
    static let none: Self           = []
}

struct FRUltraWidescreenResolution: FilterResultsModel {
    let rawValue: Int
    
    
    static let allOptions: [String] = [
        "Ultrawide Standard",
        "2560x1080",
        "3440x1440",
    ]
    
    static let ultrawideStandard    = FRUltraWidescreenResolution(rawValue: 1 << 0)
    static let resolution2560x1080  = FRUltraWidescreenResolution(rawValue: 1 << 1)
    static let resolution3440x1440  = FRUltraWidescreenResolution(rawValue: 1 << 2)
    
    static let all: FRUltraWidescreenResolution = [.ultrawideStandard, resolution2560x1080, .resolution3440x1440]
    static let none: FRUltraWidescreenResolution = []
}

struct FRDualscreenResolution: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions: [String] = [
        "Dual Standard",
        "3840x1080",
        "5120x1440",
        "7680x2160"
    ]
    
    static let dualStandard         = Self.init(rawValue: 1 << 0)
    static let resolution3840x1080  = Self.init(rawValue: 1 << 1)
    static let resolution5120x1440  = Self.init(rawValue: 1 << 2)
    static let resolution7680x2160  = Self.init(rawValue: 1 << 3)
    
    static let all: Self = [.dualStandard, .resolution3840x1080, .resolution5120x1440, .resolution7680x2160]
    static let none: Self = []
}

struct FRTriplescreenResolution: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions: [String] = [
            "Triple Standard",
            "4096x768",
            "5760x1080",
            "7680x1440",
            "11520x2160"
        ]
    
    static let tripleStandard        = FRTriplescreenResolution(rawValue: 1 << 0)
    static let resolution4096x768    = FRTriplescreenResolution(rawValue: 1 << 1)
    static let resolution5760x1080   = FRTriplescreenResolution(rawValue: 1 << 2)
    static let resolution7680x1440   = FRTriplescreenResolution(rawValue: 1 << 3)
    static let resolution11520x2160  = FRTriplescreenResolution(rawValue: 1 << 4)
    
    static let all: FRTriplescreenResolution = [.tripleStandard, resolution4096x768, resolution5760x1080, resolution7680x1440, resolution11520x2160]
    static let none: FRTriplescreenResolution = []
}

struct FRPortraitScreenResolution: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions = [
        "PotraitStandard",
        "720x1280",
        "1080x1920",
        "1440x2560",
        "2160x3840"
    ]
    
    static let portraitStandard     = Self.init(rawValue: 1 << 0)
    static let resolution720x1280   = Self.init(rawValue: 1 << 1)
    static let resolution1080x1920  = Self.init(rawValue: 1 << 2)
    static let resolution1440x2560  = Self.init(rawValue: 1 << 3)
    static let resolution2160x3840  = Self.init(rawValue: 1 << 4)
    
    static let all: Self            = [.portraitStandard, .resolution720x1280, .resolution1080x1920, .resolution1440x2560, .resolution2160x3840]
    static let none: Self           = []
}

struct FRMiscResolution: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions = [
        "OtherResolution",
        "DynamicResolution"
    ]
    
    static let otherResolution     = Self.init(rawValue: 1 << 0)
    static let dynamicResolution   = Self.init(rawValue: 1 << 1)
    
    static let all: Self           = [.otherResolution, .dynamicResolution]
    static let none: Self          = []
}

struct FRSource: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions = [
        "Official",
        "Workshop",
        "MyWallpapers"
    ]
    
    static let official        = Self.init(rawValue: 1 << 0)
    static let workshop        = Self.init(rawValue: 1 << 1)
    static let myWallpapers    = Self.init(rawValue: 1 << 2)
    
    static let all: Self       = [.official, .workshop, .myWallpapers]
    static let none: Self      = []
}

struct FRTag: FilterResultsModel {
    let rawValue: Int
    
    static let allOptions = [
        "Abstract",
        "Animal",
        "Anime",
        "Cartoon",
        "CGI",
        "Cyberpunk",
        "Fantasy",
        "Game",
        "Girls",
        "Guys",
        "Landscape",
        "Medieval",
        "Memes",
        "MMD",
        "Music",
        "Nature",
        "PixelArt",
        "Relaxing",
        "Retro",
        "Sci-Fi",
        "Sports",
        "Technology",
        "Television",
        "Vehicle",
        "UnspecifiedGenre"
    ]
    
    static let abstract             = FRTag(rawValue: 1 << 0)
    static let animal               = FRTag(rawValue: 1 << 1)
    static let anime                = FRTag(rawValue: 1 << 2)
    static let cartoon              = FRTag(rawValue: 1 << 3)
    static let cgi                  = FRTag(rawValue: 1 << 4)
    static let cyberpunk            = FRTag(rawValue: 1 << 5)
    static let fantasy              = FRTag(rawValue: 1 << 6)
    static let game                 = FRTag(rawValue: 1 << 7)
    static let girls                = FRTag(rawValue: 1 << 8)
    static let guys                 = FRTag(rawValue: 1 << 9)
    static let landscape            = FRTag(rawValue: 1 << 10)
    static let medieval             = FRTag(rawValue: 1 << 11)
    static let memes                = FRTag(rawValue: 1 << 12)
    static let mmd                  = FRTag(rawValue: 1 << 13)
    static let music                = FRTag(rawValue: 1 << 14)
    static let nature               = FRTag(rawValue: 1 << 15)
    static let pixelArt             = FRTag(rawValue: 1 << 16)
    static let relaxing             = FRTag(rawValue: 1 << 17)
    static let retro                = FRTag(rawValue: 1 << 18)
    static let sciFi                = FRTag(rawValue: 1 << 19)
    static let sports               = FRTag(rawValue: 1 << 20)
    static let technology           = FRTag(rawValue: 1 << 21)
    static let television           = FRTag(rawValue: 1 << 22)
    static let vehicle              = FRTag(rawValue: 1 << 23)
    static let unspecifiedGenre     = FRTag(rawValue: 1 << 24)
    
    static let all: FRTag = [
        .abstract, .animal, .anime, .cartoon, .cgi, .cyberpunk, .fantasy, .game, .girls,
        .guys, .landscape, .medieval, .memes, .mmd, .music, .nature, .pixelArt, .relaxing,
        .retro, .sciFi, .sports, .technology, .television, .vehicle, .unspecifiedGenre
    ]
    static let none: FRTag = []
}

// MARK: - View Model
class FilterResultsViewModel: ObservableObject {
    @AppStorage("FRShowOnly")                   public var showOnly = FRShowOnly.all
    @AppStorage("FRType")                       public var type = FRType.all
    @AppStorage("FRAgeRating")                  public var ageRating = FRAgeRating.all
    @AppStorage("FRWidescreenResolution")       public var widescreenResolution = FRWidescreenResolution.all
    @AppStorage("FRUltraWidescreenResolution")  public var ultraWidescreenResolution = FRUltraWidescreenResolution.all
    @AppStorage("FRDualscreenResolution")       public var dualscreenResolution = FRDualscreenResolution.all
    @AppStorage("FRTriplescreenResolution")     public var triplescreenResolution = FRTriplescreenResolution.all
    @AppStorage("FRPortraitScreenResolution")   public var potraitscreenResolution = FRPortraitScreenResolution.all
    @AppStorage("FRMiscResolution")             public var miscResolution = FRMiscResolution.all
    @AppStorage("FRSource")                     public var source = FRSource.all
    @AppStorage("FRTag")                        public var tag = FRTag.all
    
    public func reset() {
        self.showOnly                   = .none // notice it's show ONLY, it acts oppositely to the others
        self.type                       = .all
        self.ageRating                  = .all
        self.type                       = .all
        self.ageRating                  = .all
        self.widescreenResolution       = .all
        self.ultraWidescreenResolution  = .all
        self.dualscreenResolution       = .all
        self.triplescreenResolution     = .all
        self.potraitscreenResolution    = .all
        self.miscResolution             = .all
        self.source                     = .all
        self.tag                        = .all
    }
}

struct FilterResults: View {
    @ObservedObject var viewModel: FilterResultsViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 30) {
                    Button {
                        viewModel.reset()
                    } label: {
                        Label("Reset Filters", systemImage: "arrow.triangle.2.circlepath")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    VStack(alignment: .leading) {
                        Group {
                            ForEach(Array(zip(FRShowOnly.allOptions.indices, FRShowOnly.allOptions)), id: \.0) { (i, option) in
                                let (option, image) = option
                                let color: Color = {
                                    if i == 0 {
                                        return Color.green
                                    } else if i == 1 {
                                        return Color.pink
                                    } else if i == 2 {
                                        return Color.orange
                                    } else {
                                        return Color.accentColor
                                    }
                                }()
                                Toggle(isOn: Binding<Bool>(get: {
                                    viewModel.showOnly.contains(FRShowOnly(rawValue: 1 << i))
                                }, set: {
                                    if $0 {
                                        viewModel.showOnly.insert(FRShowOnly(rawValue: 1 << i))
                                    } else {
                                        viewModel.showOnly.remove(FRShowOnly(rawValue: 1 << i))
                                    }
                                    print(String(describing: viewModel.showOnly))
                                })) {
                                    HStack(spacing: 2) {
                                        Image(systemName: image)
                                            .foregroundStyle(color)
                                        Text(option)
                                    }
                                }
                            }
                        }
                        .toggleStyle(.checkbox)
                    }
                    .padding(.all)
                    .padding(.top)
                    .overlay {
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(Color(nsColor: NSColor.unemphasizedSelectedTextBackgroundColor))
                                .padding(.top, 8)
                            VStack {
                                HStack {
                                    Text("Show Only:")
                                        .background(Color(nsColor: NSColor.windowBackgroundColor))
                                        .padding(.leading, 5)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                    }
                    VStack(spacing: 15) {
                        FilterSection("Type", alignment: .leading) {
                            ForEach(Array(zip(FRType.allOptions.indices, FRType.allOptions)), id: \.0) { (i, option) in
                                Toggle(option, isOn: Binding<Bool>(get: {
                                    viewModel.type.contains(FRType(rawValue: 1 << i))
                                }, set: {
                                    if $0 {
                                        viewModel.type.insert(FRType(rawValue: 1 << i))
                                    } else {
                                        viewModel.type.remove(FRType(rawValue: 1 << i))
                                    }
                                    print(String(describing: viewModel.type))
                                }))
                                if i == 3 {
                                    Divider()
                                        .overlay(Color.accentColor)
                                }
                            }
                        }
                        FilterSection("Age Rating", alignment: .leading) {
                            ForEach(Array(zip(FRAgeRating.allOptions.indices, FRAgeRating.allOptions)), id: \.0) { (i, option) in
                                Toggle(option, isOn: Binding<Bool>(get: {
                                    viewModel.ageRating.contains(FRAgeRating(rawValue: 1 << i))
                                }, set: {
                                    if $0 {
                                        viewModel.ageRating.insert(FRAgeRating(rawValue: 1 << i))
                                    } else {
                                        viewModel.ageRating.remove(FRAgeRating(rawValue: 1 << i))
                                    }
                                    print(String(describing: viewModel.ageRating))
                                }))
                            }
                        }
                        FilterSection("Resolution", alignment: .leading) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Widescreen")
                                        .bold()
                                    HStack {
                                        Button("All")  {
                                            viewModel.widescreenResolution = .all
                                        }
                                        Button("None") {
                                            viewModel.widescreenResolution = .none
                                        }
                                    }
                                    .buttonStyle(.link)
                                }
                                .padding(.top, 5)
                                Group {
                                    ForEach(Array(zip(FRWidescreenResolution.allOptions.indices, FRWidescreenResolution.allOptions)), id: \.0) { (i, option) in
                                        Toggle(option, isOn: Binding<Bool>(get: {
                                            viewModel.widescreenResolution.contains(FRWidescreenResolution(rawValue: 1 << i))
                                        }, set: {
                                            if $0 {
                                                viewModel.widescreenResolution.insert(FRWidescreenResolution(rawValue: 1 << i))
                                            } else {
                                                viewModel.widescreenResolution.remove(FRWidescreenResolution(rawValue: 1 << i))
                                            }
                                            print(String(describing: viewModel.widescreenResolution))
                                        }))
                                    }
                                }
                                .toggleStyle(.checkbox)
                                Divider()
                                    .overlay(Color.accentColor)
                            }
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Ultra Widescreen")
                                        .bold()
                                    HStack {
                                        Button("All")  {
                                            viewModel.ultraWidescreenResolution = .all
                                        }
                                        Button("None") {
                                            viewModel.ultraWidescreenResolution = .none
                                        }
                                    }
                                    .buttonStyle(.link)
                                }
                                .padding(.top, 5)
                                Group {
                                    ForEach(Array(zip(FRUltraWidescreenResolution.allOptions.indices, FRUltraWidescreenResolution.allOptions)), id: \.0) { (i, option) in
                                        Toggle(option, isOn: Binding<Bool>(get: {
                                            viewModel.ultraWidescreenResolution.contains(FRUltraWidescreenResolution(rawValue: 1 << i))
                                        }, set: {
                                            if $0 {
                                                viewModel.ultraWidescreenResolution.insert(FRUltraWidescreenResolution(rawValue: 1 << i))
                                            } else {
                                                viewModel.ultraWidescreenResolution.remove(FRUltraWidescreenResolution(rawValue: 1 << i))
                                            }
                                            print(String(describing: viewModel.ultraWidescreenResolution))
                                        }))
                                    }
                                }
                                .toggleStyle(.checkbox)
                                Divider()
                                    .overlay(Color.accentColor)
                            }
                            VStack(alignment: .leading) {
                                // MARK: - have trouble
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Dual Monitor")
                                        .bold()
                                    HStack {
                                        Button("All")  { 
                                            viewModel.dualscreenResolution = .all
                                        }
                                        Button("None") {
                                            viewModel.dualscreenResolution = .none
                                        }
                                    }
                                    .buttonStyle(.link)
                                }
                                .padding(.top, 5)
                                Group {
                                    ForEach(Array(zip(FRDualscreenResolution.allOptions.indices, FRDualscreenResolution.allOptions)), id: \.0) { (i, option) in
                                        Toggle(option, isOn: Binding<Bool>(get: {
                                            viewModel.dualscreenResolution.contains(FRDualscreenResolution(rawValue: 1 << i))
                                        }, set: {
                                            if $0 {
                                                viewModel.dualscreenResolution.insert(FRDualscreenResolution(rawValue: 1 << i))
                                            } else {
                                                viewModel.dualscreenResolution.remove(FRDualscreenResolution(rawValue: 1 << i))
                                            }
                                            print(String(describing: viewModel.dualscreenResolution))
                                        }))
                                    }
                                }
                                .toggleStyle(.checkbox)
                                Divider()
                                    .overlay(Color.accentColor)
                            }
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Triple Monitor")
                                        .bold()
                                    HStack {
                                        Button("All")  { 
                                            viewModel.triplescreenResolution = .all
                                        }
                                        Button("None") {
                                            viewModel.triplescreenResolution = .none
                                        }
                                    }
                                    .buttonStyle(.link)
                                }
                                .padding(.top, 5)
                                Group {
                                    ForEach(Array(zip(FRTriplescreenResolution.allOptions.indices, FRTriplescreenResolution.allOptions)), id: \.0) { (i, option) in
                                        Toggle(option, isOn: Binding<Bool>(get: {
                                            viewModel.triplescreenResolution.contains(FRTriplescreenResolution(rawValue: 1 << i))
                                        }, set: {
                                            if $0 {
                                                viewModel.triplescreenResolution.insert(FRTriplescreenResolution(rawValue: 1 << i))
                                            } else {
                                                viewModel.triplescreenResolution.remove(FRTriplescreenResolution(rawValue: 1 << i))
                                            }
                                            print(String(describing: viewModel.triplescreenResolution))
                                        }))
                                    }
                                }
                                .toggleStyle(.checkbox)
                                Divider()
                                    .overlay(Color.accentColor)
                            }
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("Potrait Monitor / Phone")
                                        .bold()
                                    HStack {
                                        Button("All")  {
                                            viewModel.potraitscreenResolution = .all
                                        }
                                        Button("None") { 
                                            viewModel.potraitscreenResolution = .none
                                        }
                                    }
                                    .buttonStyle(.link)
                                }
                                .padding(.top, 5)
                                Group {
                                    ForEach(Array(zip(FRPortraitScreenResolution.allOptions.indices, FRPortraitScreenResolution.allOptions)), id: \.0) { (i, option) in
                                        Toggle(option, isOn: Binding<Bool>(get: {
                                            viewModel.potraitscreenResolution.contains(FRPortraitScreenResolution(rawValue: 1 << i))
                                        }, set: {
                                            if $0 {
                                                viewModel.potraitscreenResolution.insert(FRPortraitScreenResolution(rawValue: 1 << i))
                                            } else {
                                                viewModel.potraitscreenResolution.remove(FRPortraitScreenResolution(rawValue: 1 << i))
                                            }
                                            print(String(describing: viewModel.potraitscreenResolution))
                                        }))
                                    }
                                }
                                .toggleStyle(.checkbox)
                                Divider()
                                    .overlay(Color.accentColor)
                            }
                            Group {
                                ForEach(Array(zip(FRMiscResolution.allOptions.indices, FRMiscResolution.allOptions)), id: \.0) { (i, option) in
                                    Toggle(option, isOn: Binding<Bool>(get: {
                                        viewModel.miscResolution.contains(FRMiscResolution(rawValue: 1 << i))
                                    }, set: {
                                        if $0 {
                                            viewModel.miscResolution.insert(FRMiscResolution(rawValue: 1 << i))
                                        } else {
                                            viewModel.miscResolution.remove(FRMiscResolution(rawValue: 1 << i))
                                        }
                                        print(String(describing: viewModel.miscResolution))
                                    }))
                                }
                            }
                            .toggleStyle(.checkbox)
                        }
                        FilterSection("Source", alignment: .leading) {
                            Group {
                                ForEach(Array(zip(FRSource.allOptions.indices, FRSource.allOptions)), id: \.0) { (i, option) in
                                    Toggle(option, isOn: Binding<Bool>(get: {
                                        viewModel.source.contains(FRSource(rawValue: 1 << i))
                                    }, set: {
                                        if $0 {
                                            viewModel.source.insert(FRSource(rawValue: 1 << i))
                                        } else {
                                            viewModel.source.remove(FRSource(rawValue: 1 << i))
                                        }
                                        print(String(describing: viewModel.source))
                                    }))
                                }
                            }
                            .toggleStyle(.checkbox)
                        }
                        FilterSection("Tags", alignment: .leading) {
                            HStack {
                                Button("All")  {
                                    viewModel.tag = .all
                                }
                                Button("None") { 
                                    viewModel.tag = .none
                                }
                            }
                            .buttonStyle(.link)
                            Group {
                                ForEach(Array(zip(FRTag.allOptions.indices, FRTag.allOptions)), id: \.0) { (i, option) in
                                    Toggle(option, isOn: Binding<Bool>(get: {
                                        viewModel.tag.contains(FRTag(rawValue: 1 << i))
                                    }, set: {
                                        if $0 {
                                            viewModel.tag.insert(FRTag(rawValue: 1 << i))
                                        } else {
                                            viewModel.tag.remove(FRTag(rawValue: 1 << i))
                                        }
                                        print(String(describing: viewModel.tag))
                                    }))
                                }
                            }
                            .toggleStyle(.checkbox)
                        }
                    }
                }
                .padding(.trailing)
            }
        }
        Divider()
    }
}
