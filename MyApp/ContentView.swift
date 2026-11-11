  import SwiftUI

struct ContentView: View {
    @State private var showReminder = false
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Divider()
                
                Spacer()
                
                Divider()
                
                Spacer()
                
                Image("plant2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .frame(maxWidth: .infinity)
                
                
                
                Text("Start your plant journey!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                
                Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                
                Spacer()
                
             
                    Button {
                        showReminder = true
                    } label: {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 280, height: 42)
                            .background(Color.green)
                            .clipShape(Capsule())
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 60)
                    .padding(.bottom, 60)
                    .sheet(isPresented: $showReminder) {
                        ReminderView()
                    }
                }
                .padding()
                
            }
        }
    }

#Preview {
    ContentView()
}
