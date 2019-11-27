// swift-tools-version:5.0
import PackageDescription

let buildTests = false

let package = Package(
    name: "RxRequester",
    platforms: [
       .macOS(.v10_12), .iOS(.v11),
    ],
    products: [
        .library(name: "RxRequester", targets: ["RxRequester"]),
        .library(name: "RxRequesterAlamofire", targets: ["RxRequesterAlamofire"]),
        .library(name: "RxRequesterMoya", targets: ["RxRequesterMoya"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.0.0-rc.3")),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0-beta.5")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
         .target(
            name: "RxRequester",
            dependencies: ["RxSwift"],
            exclude: [
                "Tests",
                "Examples"]),
        .target(
            name: "RxRequesterAlamofire",
            dependencies: [
                "RxRequester",
                "Alamofire"],
            exclude: [
                "Tests",
                "Tests",
                "Examples"]),
        .target(
            name: "RxRequesterMoya",
            dependencies: [
                "RxRequester",
                "Moya"],
            exclude: [
                "Tests",
                "Tests",
                "Examples"])
    ]
)
