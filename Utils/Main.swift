// Created by Folt
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

    static func discover(ip: String, timeout: TimeInterval = 3.0) -> Bulb? {
        print("🔎 Discovering Yeelight at IP: \(ip)...")

        guard let caps = ssdpDiscover(ipFilter: ip, timeout: timeout) else {
            print("💤 No response from \(ip)")
            return nil
        }

        print("✅ Found bulb at \(ip):")
        for (k, v) in caps {
            print("\(k): \(v)")
        }

        return Bulb(ip: ip)
    }

    private static func ssdpDiscover(ipFilter: String, timeout: TimeInterval) -> [String: String]? {
        let message = """
        M-SEARCH * HTTP/1.1\r
        HOST: 239.255.255.250:1982\r
        MAN: "ssdp:discover"\r
        ST: wifi_bulb\r
        \r
        """

        let socketFD = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)
        guard socketFD >= 0 else {
            print("❌ Failed to create socket")
            return nil
        }

        var enable: Int32 = 1
        setsockopt(socketFD, SOL_SOCKET, SO_BROADCAST, &enable, socklen_t(MemoryLayout<Int32>.size))

        var flags = fcntl(socketFD, F_GETFL)
        fcntl(socketFD, F_SETFL, flags | O_NONBLOCK)

        var addr = sockaddr_in()
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_port = in_port_t(1982).bigEndian
        addr.sin_addr.s_addr = inet_addr("239.255.255.250")

        let data = [UInt8](message.utf8)
        withUnsafePointer(to: &addr) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                sendto(socketFD, data, data.count, 0, $0, socklen_t(MemoryLayout<sockaddr_in>.size))
            }
        }

        print("📡 SSDP packet sent")

        var buffer = [UInt8](repeating: 0, count: 2048)
        var fromAddr = sockaddr_in()
        var fromLen: socklen_t = socklen_t(MemoryLayout<sockaddr_in>.size)

        let deadline = Date().addingTimeInterval(timeout)

        while Date() < deadline {
            let received = withUnsafeMutablePointer(to: &fromAddr) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    recvfrom(socketFD, &buffer, buffer.count, 0, $0, &fromLen)
                }
            }

            if received > 0 {
                let responseData = buffer.prefix(received)
                if let response = String(bytes: responseData, encoding: .utf8) {
                    if let locationLine = response.lowercased().components(separatedBy: "\r\n").first(where: { $0.hasPrefix("location:") }),
                    locationLine.contains(ipFilter) {
                        close(socketFD)
                        return parseCapabilities(from: response)
                    } else {
                        print("⛔️ Skipping non-matching IP response")
                    }
                }
            }

            usleep(100_000)
        }

        print("🕒 Timeout waiting for \(ipFilter)")
        close(socketFD)
        return nil
    }

    private static func parseCapabilities(from response: String) -> [String: String] {
        var result: [String: String] = [:]
        for line in response.components(separatedBy: "\r\n") {
            let parts = line.split(separator: ":", maxSplits: 1)
            if parts.count == 2 {
                let key = parts[0].trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                let value = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
                result[key] = value
            }
        }
        return result
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
        ensureOn: Bool = true,
        completion: @Sendable @escaping (Result<[String: Any], Error>) -> Void
    ) {
        let clampedR = min(max(red, 0), 255)
        let clampedG = min(max(green, 0), 255)
        let clampedB = min(max(blue, 0), 255)
        let rgbValue = (clampedR << 16) | (clampedG << 8) | clampedB

        let send = {
            self.sendCommand(
                method: "set_rgb",
                params: [rgbValue, "smooth", 300, lightType.rawValue],
                completion: completion
            )
        }

        if ensureOn {
            turnOn(lightType: lightType) { result in
                switch result {
                case .success: send()
                case .failure(let error): completion(.failure(error))
                }
            }
        } else {
            send()
        }
    }
}

func demoUsage() {
    if let bulb = Bulb.discover(ip: "192.168.0.25") {
        bulb.connect()
        bulb.turnOn { _ in }
    }
}
