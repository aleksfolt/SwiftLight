//
//  Main.swift
//  SwiftLight
//
//  Created by Folt on 31/5/25.
//

import Foundation
import Network

struct ColorTemp {
    let min: Int
    let max: Int
}

struct ModelSpec {
    let colorTemp: ColorTemp
    let nightLight: Bool
    let backgroundLight: Bool
    let bulbType: BulbType?
}

enum BulbType {
    case white
    case whiteTempMood
}

let deafaultProps: [String] = [
    "power",
    "bright",
    "ct",
    "rgb",
    "hue",
    "sat",
    "color_mode",
    "flowing",
    "delayoff",
    "music_on",
    "name",
    "bg_power",
    "bg_flowing",
    "bg_ct",
    "bg_bright",
    "bg_hue",
    "bg_sat",
    "bg_rgb",
    "nl_br",
    "active_mode",
]


let modelSpecs: [String: ModelSpec] = [
    "bslamp1": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "bslamp2": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "bslamp3": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceil26": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceila": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceilc": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: true, bulbType: nil),
    "ceild": ModelSpec(colorTemp: ColorTemp(min: 3000, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling10": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: true, bulbType: nil),
    "ceiling13": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling15": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling17": ModelSpec(colorTemp: ColorTemp(min: 3000, max: 5700), nightLight: false, backgroundLight: false, bulbType: nil),
    "ceiling18": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling19": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: true, bulbType: nil),
    "ceiling1": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling20": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: true, bulbType: nil),
    "ceiling24": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling2": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling3": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling4": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: true, bulbType: nil),
    "ceiling5": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 5700), nightLight: true, backgroundLight: false, bulbType: nil),
    "ceiling6": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: true, backgroundLight: false, bulbType: nil),
    "color1": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "color2": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "color4": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "color5": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "colorc": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "color": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "ct_bulb": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "ct2": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "lamp1": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 5000), nightLight: false, backgroundLight: false, bulbType: nil),
    "lamp3": ModelSpec(colorTemp: ColorTemp(min: 4000, max: 4000), nightLight: false, backgroundLight: false, bulbType: .white),
    "lamp4": ModelSpec(colorTemp: ColorTemp(min: 2600, max: 5000), nightLight: false, backgroundLight: false, bulbType: nil),
    "lamp15": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: false, backgroundLight: true, bulbType: .whiteTempMood),
    "mono1": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 2700), nightLight: false, backgroundLight: false, bulbType: nil),
    "mono5": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 2700), nightLight: false, backgroundLight: false, bulbType: nil),
    "mono6": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 2700), nightLight: false, backgroundLight: false, bulbType: nil),
    "mono": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 2700), nightLight: false, backgroundLight: false, bulbType: nil),
    "monob": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 2700), nightLight: false, backgroundLight: false, bulbType: nil),
    "strip1": ModelSpec(colorTemp: ColorTemp(min: 1700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "strip2": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "strip4": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil),
    "strip6": ModelSpec(colorTemp: ColorTemp(min: 2700, max: 6500), nightLight: false, backgroundLight: false, bulbType: nil)
]

func getKnownModels() -> Array<String> {
    return Array(modelSpecs.keys)
}

@available(macOS 10.15, *)
final class Bulb: @unchecked Sendable {
    private var connection: NWConnection?
    private var cmdID = 1
    private let host: NWEndpoint.Host
    private let port: NWEndpoint.Port = 55443

    init(ip: String) {
        self.host = NWEndpoint.Host(ip)
    }

    func connect() {
        connection = NWConnection(host: host, port: port, using: .tcp)
        connection?.start(queue: .global())
    }

    func sendCommand(
        method: String,
        params: [Any],
        completion: @escaping @Sendable (Result<[String: Any], Error>) -> Void
    ) {
        let command: [String: Any] = [
            "id": cmdID,
            "method": method,
            "params": params
        ]
        cmdID += 1

        guard let jsonData = try? JSONSerialization.data(withJSONObject: command),
              let request = String(data: jsonData, encoding: .utf8)?.appending("\r\n").data(using: .utf8)
        else {
            completion(.failure(NSError(domain: "EncodingError", code: 0)))
            return
        }

        guard let connection = connection else {
            completion(.failure(NSError(domain: "Connection not initialized", code: 0)))
            return
        }

        connection.send(content: request, completion: .contentProcessed({ error in
            if let error = error {
                completion(.failure(error))
                return
            }

            connection.send(content: " ".data(using: .utf8), completion: .contentProcessed({ _ in }))

            self.receiveResponse(completion: completion)
        }))
    }

    private func receiveResponse(completion: @escaping @Sendable (Result<[String: Any], Error>) -> Void) {
        connection?.receive(minimumIncompleteLength: 1, maximumLength: 16 * 1024) { data, _, isComplete, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "Invalid data", code: 0)))
                return
            }
            print("RAW:", responseString)


            for line in responseString.split(separator: "\r\n") {
                if let lineData = line.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: lineData) as? [String: Any],
                   json["method"] as? String != "props" {
                    completion(.success(json))
                    return
                }
            }

            if isComplete {
                completion(.failure(NSError(domain: "Connection closed", code: 0)))
            } else {
                self.receiveResponse(completion: completion)
            }
        }
    }

    func setBrightness(
        _ value: Int,
        completion: @Sendable @escaping (Result<[String: Any], Error>) -> Void
    ) {
        let brightness = min(max(value, 1), 100)
        sendCommand(method: "set_bright", params: [brightness, "smooth", 300], completion: completion)
    }
}

@available(macOS 10.15, *)
extension Bulb {
    enum LightType: Int {
        case main = 0
        case background = 1
    }

    func turnOn(
        lightType: LightType = .main,
        completion: @Sendable @escaping (Result<[String: Any], Error>) -> Void
    ) {
        sendCommand(
            method: "set_power",
            params: ["on", "smooth", 300, lightType.rawValue],
            completion: completion
        )
    }

    func turnOff(
        lightType: LightType = .main,
        completion: @Sendable @escaping (Result<[String: Any], Error>) -> Void
    ) {
        sendCommand(
            method: "set_power",
            params: ["off", "smooth", 300, lightType.rawValue],
            completion: completion
        )
    }

    func setRGB(
        red: Int,
        green: Int,
        blue: Int,
        lightType: LightType = .main,
        completion: @Sendable @escaping (Result<[String: Any], Error>) -> Void
    ) {
        turnOn(lightType: lightType) { [weak self] turnOnResult in
            switch turnOnResult {
            case .success:
                let clampedR = min(max(red, 0), 255)
                let clampedG = min(max(green, 0), 255)
                let clampedB = min(max(blue, 0), 255)
                let rgbValue = (clampedR << 16) | (clampedG << 8) | clampedB

                self?.sendCommand(
                    method: "set_rgb",
                    params: [rgbValue, "smooth", 300, lightType.rawValue],
                    completion: completion
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

func demoUsage() {
    let bulb = Bulb(ip: "192.168.0.25")
    bulb.connect()
    bulb.turnOff { _ in}
}
