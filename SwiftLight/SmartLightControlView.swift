//
//  SmartLightControlView.swift
//  SwiftLight
//
//  Created by Folt on 31/5/25.
//

import SwiftUI
import Network

@available(macOS 10.15, *)
struct SmartLightControlView: View {
    @State private var lampIP: String = ""
    @State private var isConnected: Bool = false
    @State private var bulb: Bulb?
    @State private var discoveredDevices: [SSDPResponse] = []

    @State private var isOn: Bool = false
    @State private var brightness: Double = 0.85
    @State private var selectedColor: Color = .white
    @State private var temperatures: [Color] = [
        Color(red: 1.0, green: 0.8, blue: 0.3),
        Color(red: 1.0, green: 0.9, blue: 0.5),
        Color(red: 1.0, green: 0.95, blue: 0.7),
        Color(red: 1.0, green: 1.0, blue: 1.0),
        Color(red: 0.8, green: 0.9, blue: 1.0),
        Color(red: 0.6, green: 0.8, blue: 1.0),
        Color(red: 0.4, green: 0.7, blue: 1.0),
        Color(red: 0.2, green: 0.6, blue: 1.0),
        Color(red: 0.0, green: 0.5, blue: 1.0)
    ]
    @State private var selectedTempIndex: Int = 3

    private let ctMin: Int = 1700
    private let ctMax: Int = 6500

    var body: some View {
        VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Lamp IP")
                    .font(.headline)
                    .foregroundColor(.white)

                HStack(spacing: 8) {
                    TextField("192.168.1.100", text: $lampIP)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(8)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )

                    Button {
                        connectToLamp()
                    } label: {
                        Text(isConnected ? "Reconnect" : "Connect")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.yellow.opacity(0.7))
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(lampIP.trimmingCharacters(in: .whitespaces).isEmpty)
                }

                if lampIP.isEmpty && !discoveredDevices.isEmpty {
                    VStack(spacing: 2) {
                        ForEach(discoveredDevices, id: \.ip) { device in
                            let labelText = label(for: device)
                            Button(action: {
                                lampIP = device.ip
                            }) {
                                Text(labelText)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(6)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(maxHeight: 80)
                    .padding(.top, 2)
                }
            }

            Divider().background(Color.white.opacity(0.2))

            powerButton
                .disabled(!isConnected)

            Divider().background(Color.white.opacity(0.2))

            brightnessSlider
                .disabled(!isConnected)

            Divider().background(Color.white.opacity(0.2))

            colorPickerView
                .disabled(!isConnected)

            Divider().background(Color.white.opacity(0.2))

            temperatureGrid
                .disabled(!isConnected)
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .frame(maxWidth: 360)
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).async {
                let bulbs = discoverBulbs(timeout: 2, interface: nil)
                DispatchQueue.main.async {
                    discoveredDevices = bulbs
                }
            }
        }
        .onChange(of: selectedColor) { newColor in
            if isConnected, let bulb = bulb {
                sendRGBColor(newColor, to: bulb)
            }
        }
        .onChange(of: selectedTempIndex) { newIndex in
            if isConnected, let bulb = bulb {
                let ctValue = ctMin + Int(Double(ctMax - ctMin) * (Double(newIndex) / Double(temperatures.count - 1)))
                bulb.sendCommand(
                    method: "set_ct_abx",
                    params: [ctValue, "smooth", 300, Bulb.LightType.main.rawValue]
                ) { _ in }
            }
        }
    }

    private func label(for device: SSDPResponse) -> String {
        if let name = device.capabilities["name"], !name.isEmpty {
            return name
        }
        if let model = device.capabilities["model"], !model.isEmpty {
            return model
        }
        return device.ip
    }
}

@available(macOS 10.15, *)
private extension SmartLightControlView {
    var powerButton: some View {
        Button {
            guard let bulb = bulb else { return }
            withAnimation { isOn.toggle() }
            if isOn {
                bulb.turnOn(lightType: .main) { _ in }
            } else {
                bulb.turnOff(lightType: .main) { _ in }
            }
        } label: {
            ZStack {
                Circle()
                    .fill(isOn ? Color.yellow : Color.gray.opacity(0.5))
                    .frame(width: 80, height: 80)
                Image(systemName: "power")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            .shadow(color: isOn ? Color.yellow.opacity(0.6) : .clear, radius: 6, x: 0, y: 0)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(isOn ? "Light Off" : "Light On")
    }

    var brightnessSlider: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Brightness")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("\(Int(brightness * 100))%")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            Slider(
                value: $brightness,
                in: 0...1,
                onEditingChanged: { editing in
                    if !editing, isConnected, let bulb = bulb {
                        let intValue = Int(brightness * 100)
                        bulb.setBrightness(intValue) { _ in }
                    }
                }
            )
            .accentColor(.yellow)
        }
        .padding(.vertical, 4)
    }

    var colorPickerView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Color (RGB)")
                .font(.headline)
                .foregroundColor(.white)
            ColorPicker("", selection: $selectedColor)
                .labelsHidden()
                .frame(maxWidth: .infinity)
        }
    }

    var temperatureGrid: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Color temperature")
                .font(.headline)
                .foregroundColor(.white)
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 3),
                spacing: 12
            ) {
                ForEach(0..<temperatures.count, id: \.self) { idx in
                    let color = temperatures[idx]
                    Circle()
                        .fill(color)
                        .frame(width: 36, height: 36)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: selectedTempIndex == idx ? 3 : 0)
                        )
                        .onTapGesture {
                            withAnimation { selectedTempIndex = idx }
                        }
                        .shadow(
                            color: selectedTempIndex == idx ? Color.white.opacity(0.4) : .clear,
                            radius: 4
                        )
                }
            }
        }
    }

    func connectToLamp() {
        let trimmedIP = lampIP.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedIP.isEmpty else { return }

        let newBulb = Bulb(ip: trimmedIP)
        newBulb.connect()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            bulb = newBulb
            isConnected = true
        }
    }

    func sendRGBColor(_ color: Color, to bulb: Bulb) {
        #if os(macOS)
        if let nsColor = NSColor(color).usingColorSpace(.deviceRGB) {
            let r = Int(nsColor.redComponent * 255)
            let g = Int(nsColor.greenComponent * 255)
            let b = Int(nsColor.blueComponent * 255)
            bulb.setRGB(red: r, green: g, blue: b, lightType: .main) { _ in }
        }
        #else
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let r = Int(red * 255), g = Int(green * 255), b = Int(blue * 255)
        bulb.setRGB(red: r, green: g, blue: b, lightType: .main) { _ in }
        #endif
    }
}

@available(macOS 10.15, *)
struct SmartLightControlView_Previews: PreviewProvider {
    static var previews: some View {
        SmartLightControlView()
            .preferredColorScheme(.dark)
    }
}

