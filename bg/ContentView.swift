import SwiftUI

struct LoadingPage: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.blue, lineWidth: 5)
                    .frame(width: 50, height: 50)
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                
                Text("Loading...your colour")
                    .font(.headline)
                    .padding(.top, 20)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct ContentView: View {
    @State private var selectedColor = Color.blue
    @State private var showingColorPicker = false
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            if isLoading {
                LoadingPage()
            } else {
                ZStack {
                    selectedColor
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        
                        Button("Change Color") {
                            showingColorPicker = true
                        }
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    .padding(.bottom, 50)
                }
                .sheet(isPresented: $showingColorPicker) {
                    ColorPicker("Select a color", selection: $selectedColor)
                        .padding()
                }
            }
        }
        .onAppear {
            // Simulate app initialization
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isLoading = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
