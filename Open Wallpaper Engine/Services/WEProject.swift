//
//  WEProject.swift
//  Open Wallpaper Engine
//
//  Created by Haren on 2023/6/5.
//

import SwiftUI
import ImageIO

struct WEProjectSchemeColor: Codable, Equatable, Hashable {
    var order: Int
    var text: String
    var type: String
    var value: String
}

struct WEProjectProperties: Codable, Equatable, Hashable {
    var schemecolor: WEProjectSchemeColor
}

struct WEProjectGeneral: Codable, Equatable, Hashable {
    var properties: WEProjectProperties
}

struct WEProject: Codable, Equatable, Hashable {
    var contentrating: String
    var description: String
    var file: String
    var general: WEProjectGeneral
    var preview: String
    var tags: [String]
    var title: String
    var visibility: String?
    var workshopid: String?
    var type: String?
    var version: Int?
}

struct WEWallpaper: Identifiable {
    var id: Int { self.project.hashValue }
    
    var wallpaperDirectory: URL
    var project: WEProject
    
    init(using project: WEProject, where url: URL) {
        self.wallpaperDirectory = url
        self.project = project
    }
}

enum WEWallpaperSortingMethod: String {
    case name, rating, likes, size, dateSubscribed, dateAdded
}

enum WEWallpaperSortingSequence: String, CaseIterable {
    case increased, decreased
}

enum WEInitError: Error {
    enum WEJSONProjectInitError: Error {
        case notFound, corrupted, mismatched, unkownError
    }
    
    enum WEResourcesInitError: Error {
        case notFound, mismatchedFormat, corrupted, unkownError
    }
    
    enum WEPreviewInitError: Error {
        case notFound, notImage, unkownError
    }
    
    case badDirectoryPath
    case JSONProject(was: WEJSONProjectInitError)
    case resources(was: WEResourcesInitError)
    case preview(was: WEPreviewInitError)
}
