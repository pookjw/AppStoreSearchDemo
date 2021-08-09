//
//  SoftwareInfoDTO.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation
import SwiftyJSON

extension SoftwareInfo {
    static func fromData(_ data: Data) throws -> [Self] {
        let json: JSON = try .init(data: data)
        
        return json["results"]
            .arrayValue
            .map { json -> SoftwareInfo in
                let artistViewUrl: URL? = json["artistViewUrl"].url
                let artworkUrl60: URL? = json["artworkUrl60"].url
                let artworkUrl100: URL? = json["artworkUrl100"].url
                let screenshotUrls: [URL?] = json["screenshotUrls"].arrayValue.map { $0.url }
                let ipadScreenshotUrls: [URL?] = json["ipadScreenshotUrls"].arrayValue.map { $0.url }
                let appletvScreenshotUrls: [URL?] = json["appletvScreenshotUrls"].arrayValue.map { $0.url }
                let artworkUrl512: URL? = json["artworkUrl512"].url
                let supportedDevices: [String] = json["supportedDevices"].arrayValue.map { $0.stringValue }
                let isGameCenterEnabled: Bool = json["isGameCenterEnabled"].boolValue
                let features: [String] = json["features"].arrayValue.map { $0.stringValue }
                let kind: String = json["kind"].stringValue
                let minimumOsVersion: String = json["minimumOsVersion"].stringValue
                let trackCensoredName: String = json["trackCensoredName"].stringValue
                let languageCodesISO2A: [String] = json["languageCodesISO2A"].arrayValue.map { $0.stringValue }
                let fileSizeBytes: UInt = json["fileSizeBytes"].numberValue.uintValue
                let formattedPrice: String = json["formattedPrice"].stringValue
                let contentAdvisoryRating: String = json["contentAdvisoryRating"].stringValue
                let averageUserRatingForCurrentVersion: UInt = json["contentAdvisoryRating"].numberValue.uintValue
                let userRatingCountForCurrentVersion: UInt = json["userRatingCountForCurrentVersion"].numberValue.uintValue
                let averageUserRating: UInt = json["averageUserRating"].numberValue.uintValue
                let trackViewUrl: URL? = json["trackViewUrl"].url
                let trackContentRating: String = json["trackContentRating"].stringValue
                let genreIds: [String] = json["genreIds"].arrayValue.map { $0.stringValue }
                let releaseDate: Date = .init()
                let sellerName: String = json["sellerName"].stringValue
                let primaryGenreName: String = json["trackConprimaryGenreNametentRating"].stringValue
                let trackId: String = json["trackId"].stringValue
                let trackName: String = json["trackName"].stringValue
                let currentVersionReleaseDate: Date = .init()
                let releaseNotes: String = json["releaseNotes"].stringValue
                let primaryGenreId: String = json["primaryGenreId"].stringValue
                let currency: String = json["currency"].stringValue
                let description: String = json["description"].stringValue
                
                return .init(artistViewUrl: artistViewUrl,
                             artworkUrl60: artworkUrl60,
                             artworkUrl100: artworkUrl100,
                             screenshotUrls: screenshotUrls,
                             ipadScreenshotUrls: ipadScreenshotUrls,
                             appletvScreenshotUrls: appletvScreenshotUrls,
                             artworkUrl512: artworkUrl512,
                             supportedDevices: supportedDevices,
                             isGameCenterEnabled: isGameCenterEnabled,
                             features: features
                             , kind: kind,
                             minimumOsVersion: minimumOsVersion,
                             trackCensoredName: trackCensoredName,
                             languageCodesISO2A: languageCodesISO2A,
                             fileSizeBytes: fileSizeBytes,
                             formattedPrice: formattedPrice,
                             contentAdvisoryRating: contentAdvisoryRating,
                             averageUserRatingForCurrentVersion: averageUserRatingForCurrentVersion,
                             userRatingCountForCurrentVersion: userRatingCountForCurrentVersion,
                             averageUserRating: averageUserRating,
                             trackViewUrl: trackViewUrl,
                             trackContentRating: trackContentRating,
                             genreIds: genreIds,
                             releaseDate: releaseDate,
                             sellerName: sellerName,
                             primaryGenreName: primaryGenreName,
                             trackId: trackId,
                             trackName: trackName,
                             currentVersionReleaseDate: currentVersionReleaseDate,
                             releaseNotes: releaseNotes,
                             primaryGenreId: primaryGenreId,
                             currency: currency,
                             description: description)
            }
    }
}
