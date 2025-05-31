import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("BackgroundImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.3)
                .blur(radius: 2)
            
            SmartLightControlView()
                .padding()
                .frame(maxWidth: 360)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

