import SwiftUI

struct ReminderView: View {
    @State private var plantName = ""
    @State private var room = "Bedroom"
    @State private var light = "Full sun"
    @State private var wateringDays = "Every day"
    @State private var water = "20-50 ml"
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Color(white: 0.11)
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.green)

                    Spacer()

                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Button("Save") {
                        dismiss()
                    }
                    .foregroundColor(.green)
                }
                HStack {
                    Text("Plant Name")
                        .foregroundColor(.white)

                    TextField("Pothos", text: $plantName)
                        .foregroundColor(.white)
                        .tint(.green)
                }
                .padding()
                .background(Color(white: 0.17))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 30)
                
                VStack(spacing: 0) {
                    HStack {
                        Label("Room", systemImage: "location")
                            .foregroundColor(.white)

                        Spacer()

                        Picker("Room", selection: $room) {
                            Text("Bedroom").tag("Bedroom")
                            Text("Living Room").tag("Living Room")
                            Text("Kitchen").tag("Kitchen")
                            Text("Balcony").tag("Balcony")
                        }
                        .tint(.gray)
                    }
                    .padding()

                    Divider()

                    HStack {
                        Label("Light", systemImage: "sun.max")
                            .foregroundColor(.white)

                        Spacer()

                        Picker("Light", selection: $light) {
                            Text("Full sun").tag("Full sun")
                            Text("Partial sun").tag("Partial sun")
                            Text("Low light").tag("Low light")
                        }
                        .tint(.gray)
                    }
                    .padding()
                }
                .background(Color(white: 0.17))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 20)
                
                VStack(spacing: 0) {
                    HStack {
                        Label("Watering Days", systemImage: "drop")
                            .foregroundColor(.white)

                        Spacer()

                        Picker("Watering Days", selection: $wateringDays) {
                            Text("Every day").tag("Every day")
                            Text("Every 2 days").tag("Every 2 days")
                            Text("Every 3 days").tag("Every 3 days")
                            Text("Once a week").tag("Once a week")
                        }
                        .tint(.gray)
                    }
                    .padding()

                    Divider()

                    HStack {
                        Label("Water", systemImage: "drop")
                            .foregroundColor(.white)

                        Spacer()

                        Picker("Water", selection: $water) {
                            Text("20-50 ml").tag("20-50 ml")
                            Text("50-100 ml").tag("50-100 ml")
                            Text("100-200 ml").tag("100-200 ml")
                            Text("200-300 ml").tag("200-300 ml")
                        }
                        .tint(.gray)
                    }
                    .padding()
                }
                .background(Color(white: 0.17))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 20)
                
                Spacer()
            }
            .padding()
        }
    }
}
