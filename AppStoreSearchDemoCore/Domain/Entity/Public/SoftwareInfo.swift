//
//  SoftwareInfo.swift
//  AppStoreSearchDemoCore
//
//  Created by Jinwoo Kim on 8/9/21.
//

import Foundation

// Initializer is hidden by internal access level...
public struct SoftwareInfo {
    public let artistViewUrl: URL?
    public let artworkUrl60: URL?
    public let artworkUrl100: URL?
    public let screenshotUrls: [URL?]
    public let ipadScreenshotUrls: [URL?]
    public let appletvScreenshotUrls: [URL?]
    public let artworkUrl512: URL?
    public let supportedDevices: [String]
    public let isGameCenterEnabled: Bool
    public let features: [String]
    public let kind: String
    public let minimumOsVersion: String
    public let trackCensoredName: String
    public let languageCodesISO2A: [String]
    public let fileSizeBytes: UInt
    public let formattedPrice: String
    public let contentAdvisoryRating: String
    public let averageUserRatingForCurrentVersion: UInt
    public let userRatingCountForCurrentVersion: UInt
    public let averageUserRating: UInt
    public let trackViewUrl: URL?
    public let trackContentRating: String
    public let genreIds: [String]
    public let releaseDate: Date
    public let sellerName: String
    public let primaryGenreName: String
    public let trackId: String
    public let trackName: String
    public let currentVersionReleaseDate: Date
    public let releaseNotes: String
    public let primaryGenreId: String
    public let currency: String
    public let description: String
}

extension SoftwareInfo: Equatable {
    public static func == (lhs: SoftwareInfo, rhs: SoftwareInfo) -> Bool {
        return lhs.trackId == rhs.trackId
    }
}

public extension SoftwareInfo {
    static var sample: Self {
        let url: URL = Bundle(identifier: "com.pookjw.AppStoreSearchDemoCore")!.url(forResource: "software_request_data_example", withExtension: "json")!
        let data: Data = try! .init(contentsOf: url)
        let infos: [SoftwareInfo] = try! SoftwareInfo.fromData(data)
        
        return infos[0]
        
//        return .init(
//            artistViewUrl: URL(string: "https://apps.apple.com/us/developer/jinwoo-kim/id1557114619?uo=4"),
//            artworkUrl60: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Purple125/v4/37/6a/02/376a0243-6bac-9bab-07bf-7afb112b5460/source/60x60bb.jpg"),
//            artworkUrl100: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Purple125/v4/37/6a/02/376a0243-6bac-9bab-07bf-7afb112b5460/source/100x100bb.jpg"),
//            screenshotUrls: [],
//            ipadScreenshotUrls: [
//            URL(string: "https://is3-ssl.mzstatic.com/image/thumb/PurpleSource114/v4/70/78/25/70782523-ba47-a05a-4288-c9243a3d7a88/b608a470-5c07-40cc-8bd4-091450d65120_8Plus_en_1.png/392x696bb.png"),
//                URL(string: "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource124/v4/7e/32/9f/7e329fe5-79c7-1def-bed9-56aa0f104e6f/2818e953-b4bb-40ad-9bcd-325019934695_8Plus_en_2.png/392x696bb.png"),
//                URL(string: "https://is5-ssl.mzstatic.com/image/thumb/PurpleSource124/v4/d8/2a/44/d82a4407-29df-ab22-9e41-0e61cedcf0e1/cd6f25b0-b7ba-4d3e-8c62-0109fa4dfc51_8Plus_en_3.png/392x696bb.png"),
//                URL(string: "https://is4-ssl.mzstatic.com/image/thumb/PurpleSource114/v4/ca/8c/1c/ca8c1caf-e7c1-f872-b943-a69322e3463d/682bef6a-4ae7-4fe9-80d0-ef113d9a8a58_8Plus_en_4.png/392x696bb.png")
//            ],
//            appletvScreenshotUrls: [],
//            artworkUrl512: URL(string: "https://is2-ssl.mzstatic.com/image/thumb/Purple125/v4/37/6a/02/376a0243-6bac-9bab-07bf-7afb112b5460/source/512x512bb.jpg"),
//            supportedDevices: [
//                "iPhone5s-iPhone5s",
//                "iPadAir-iPadAir",
//                "iPadAirCellular-iPadAirCellular",
//                "iPadMiniRetina-iPadMiniRetina",
//                "iPadMiniRetinaCellular-iPadMiniRetinaCellular",
//                "iPhone6-iPhone6",
//                "iPhone6Plus-iPhone6Plus",
//                "iPadAir2-iPadAir2",
//                "iPadAir2Cellular-iPadAir2Cellular",
//                "iPadMini3-iPadMini3",
//                "iPadMini3Cellular-iPadMini3Cellular",
//                "iPodTouchSixthGen-iPodTouchSixthGen",
//                "iPhone6s-iPhone6s",
//                "iPhone6sPlus-iPhone6sPlus",
//                "iPadMini4-iPadMini4",
//                "iPadMini4Cellular-iPadMini4Cellular",
//                "iPadPro-iPadPro",
//                "iPadProCellular-iPadProCellular",
//                "iPadPro97-iPadPro97",
//                "iPadPro97Cellular-iPadPro97Cellular",
//                "iPhoneSE-iPhoneSE",
//                "iPhone7-iPhone7",
//                "iPhone7Plus-iPhone7Plus",
//                "iPad611-iPad611",
//                "iPad612-iPad612",
//                "iPad71-iPad71",
//                "iPad72-iPad72",
//                "iPad73-iPad73",
//                "iPad74-iPad74",
//                "iPhone8-iPhone8",
//                "iPhone8Plus-iPhone8Plus",
//                "iPhoneX-iPhoneX",
//                "iPad75-iPad75",
//                "iPad76-iPad76",
//                "iPhoneXS-iPhoneXS",
//                "iPhoneXSMax-iPhoneXSMax",
//                "iPhoneXR-iPhoneXR",
//                "iPad812-iPad812",
//                "iPad834-iPad834",
//                "iPad856-iPad856",
//                "iPad878-iPad878",
//                "Watch4-Watch4",
//                "iPadMini5-iPadMini5",
//                "iPadMini5Cellular-iPadMini5Cellular",
//                "iPadAir3-iPadAir3",
//                "iPadAir3Cellular-iPadAir3Cellular",
//                "iPodTouchSeventhGen-iPodTouchSeventhGen",
//                "iPhone11-iPhone11",
//                "iPhone11Pro-iPhone11Pro",
//                "iPadSeventhGen-iPadSeventhGen",
//                "iPadSeventhGenCellular-iPadSeventhGenCellular",
//                "iPhone11ProMax-iPhone11ProMax",
//                "iPhoneSESecondGen-iPhoneSESecondGen",
//                "iPadProSecondGen-iPadProSecondGen",
//                "iPadProSecondGenCellular-iPadProSecondGenCellular",
//                "iPadProFourthGen-iPadProFourthGen",
//                "iPadProFourthGenCellular-iPadProFourthGenCellular",
//                "iPhone12Mini-iPhone12Mini",
//                "iPhone12-iPhone12",
//                "iPhone12Pro-iPhone12Pro",
//                "iPhone12ProMax-iPhone12ProMax",
//                "iPadAir4-iPadAir4",
//                "iPadAir4Cellular-iPadAir4Cellular",
//                "iPadEighthGen-iPadEighthGen",
//                "iPadEighthGenCellular-iPadEighthGenCellular",
//                "iPadProThirdGen-iPadProThirdGen",
//                "iPadProThirdGenCellular-iPadProThirdGenCellular",
//                "iPadProFifthGen-iPadProFifthGen",
//                "iPadProFifthGenCellular-iPadProFifthGenCellular"
//              ],
//            isGameCenterEnabled: false,
//            features: ["iosUniversal"],
//            kind: "software",
//            minimumOsVersion: "14.0",
//            trackCensoredName: "DoroDoro - Korean Address",
//            languageCodesISO2A: [
//                "EN",
//                "KO"
//              ],
//            fileSizeBytes: 15394816,
//            formattedPrice: "Free",
//            contentAdvisoryRating: "4+",
//            averageUserRatingForCurrentVersion: 0,
//            userRatingCountForCurrentVersion: 0,
//            averageUserRating: 0,
//            trackViewUrl: URL(string: "https://apps.apple.com/us/app/dorodoro-korean-address/id1557114617?uo=4"),
//            trackContentRating: "4+",
//            genreIds: [
//                "6006",
//                "6002"
//              ],
//            releaseDate: .init(),
//            sellerName: "Jinwoo Kim",
//            primaryGenreName: "Reference",
//            trackId: "1557114617",
//            trackName: "DoroDoro - Korean Address",
//            currentVersionReleaseDate: .init(),
//            releaseNotes: "Bug fixed.",
//            primaryGenreId: "6006",
//            currency: "USD",
//            description: "Find Korean Road Name Address (도로명주소) Easily!\n\n- You can find Korean Road Name Address (도로명주소) from keyword.\n- You can convert Korean Road Name Address (도로명주소) to English address.\n- You can find Korean Road Name Address (도로명주소) from your current location.\n- You can set Korean Road Name Address (도로명주소) as bookmark."
//        )
    }
}
