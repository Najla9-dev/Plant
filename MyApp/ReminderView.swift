import SwiftUI
import Combine

struct ReminderView: View {
    @StateObject private var viewModel: ReminderViewModel
    var onSave: (Plant) -> Void
    var onDelete: () -> Void

    @Environment(\.dismiss) private var dismiss

    let plantGreen: Color = Color(red: 0.2, green: 0.502, blue: 0.4118)
    let mintGreen: Color = Color(red: 0.36, green: 0.88, blue: 0.65)

    init(
        plantToEdit: Plant? = nil,
        onSave: @escaping (Plant) -> Void,
        onDelete: @escaping () -> Void = {}
    ) {
        _viewModel = StateObject(wrappedValue: ReminderViewModel(plantToEdit: plantToEdit))
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        ZStack {
            Color(white: 0.11)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color(white: 0.2))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Button {
                        onSave(viewModel.buildPlant())
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(plantGreen)
                            .clipShape(Circle())
                    }
                }

                HStack {
                    Text("Plant Name")
                        .foregroundColor(.white)

                    TextField("Pothos", text: $viewModel.plantName)
                        .foregroundColor(.white)
                        .tint(mintGreen)
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

                        Picker("Room", selection: $viewModel.room) {
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

                        Picker("Light", selection: $viewModel.light) {
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

                        Picker("Watering Days", selection: $viewModel.wateringDays) {
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

                        Picker("Water", selection: $viewModel.water) {
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

                if viewModel.isEditing {
                    Button {
                        onDelete()
                        dismiss()
                    } label: {
                        Text("Delete Reminder")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(white: 0.17))
                            .clipShape(Capsule())
                    }
                    .padding(.top, 30)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ReminderView(
        plantToEdit: Plant(
            name: "Pothos",
            room: "Bedroom",
            light: "Full sun",
            wateringDays: "Every day",
            water: "20-50 ml"
        )
    ) { _ in }
}
