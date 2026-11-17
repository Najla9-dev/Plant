import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = PlantsViewModel()
    @State private var showReminder = false
    @State private var selectedPlant: Plant? = nil

    let plantGreen: Color = Color(red: 0.2, green: 0.502, blue: 0.4118)
    let checkGreen: Color = Color(red: 0.36, green: 0.88, blue: 0.65)
    let progressGreen: Color = Color(red: 0.31, green: 0.62, blue: 0.52)
    let sunYellow: Color = Color(red: 0.85, green: 0.79, blue: 0.40)
    let waterBlue: Color = Color(red: 0.88, green: 0.93, blue: 0.97)
    let chipBackground: Color = Color(white: 0.13)

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Rectangle()
                    .fill(Color(white: 0.25))
                    .frame(height: 1)
                    .padding(.trailing, -16)

                if viewModel.plants.isEmpty && !viewModel.hasAddedPlant {
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

                    Button {
                        showReminder = true
                    } label: {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 280, height: 42)
                            .background(plantGreen)
                            .clipShape(Capsule())
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 60)

                } else if viewModel.plants.isEmpty {
                    Spacer()

                    Text("No reminders set yet..")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)

                    Spacer()

                } else if viewModel.allWatered {
                    Spacer()

                    Image("plant2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .frame(maxWidth: .infinity)

                    Text("All Done! 🎉")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)

                    Text("All Reminders Completed")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)

                    Spacer()

                } else {
                    Text(viewModel.wateredCount == 0 ? "Your plants are waiting for a sip 💦" : "\(viewModel.wateredCount) of your plants feel loved today✨")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)

                    ProgressView(value: viewModel.progress)
                        .tint(progressGreen)
                        .padding(.horizontal)
                        .padding(.top, 8)

                    List {
                        ForEach(viewModel.plants) { plant in
                            HStack(spacing: 12) {
                                Button {
                                    viewModel.toggleWatered(plant)
                                } label: {
                                    Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                                        .font(.title)
                                        .foregroundColor(plant.isWatered ? checkGreen : Color.gray)
                                }
                                .buttonStyle(.plain)

                                VStack(alignment: .leading, spacing: 6) {
                                    Label("in \(plant.room)", systemImage: "location")
                                        .font(.caption)
                                        .foregroundColor(.gray)

                                    Text(plant.name)
                                        .font(.title2)
                                        .foregroundColor(.white)

                                    HStack(spacing: 8) {
                                        Label(plant.light, systemImage: "sun.max")
                                            .font(.caption)
                                            .foregroundColor(sunYellow)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 5)
                                            .background(chipBackground)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))

                                        Label(plant.water, systemImage: "drop")
                                            .font(.caption)
                                            .foregroundColor(waterBlue)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 5)
                                            .background(chipBackground)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedPlant = plant
                                }
                            }
                            .opacity(plant.isWatered ? 0.4 : 1)
                            .listRowBackground(Color.black)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.deletePlant(plant)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .padding()
            .sheet(item: $selectedPlant) { plant in
                ReminderView(
                    plantToEdit: plant,
                    onSave: { updatedPlant in
                        viewModel.updatePlant(updatedPlant)
                    },
                    onDelete: {
                        viewModel.deletePlant(plant)
                    }
                )
            }

            if viewModel.hasAddedPlant {
                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        Button {
                            showReminder = true
                        } label: {
                            Image(systemName: "plus")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 56, height: 56)
                                .background(plantGreen)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(24)
            }
        }
        .sheet(isPresented: $showReminder) {
            ReminderView { plant in
                viewModel.addPlant(plant)
            }
        }
        .onAppear {
            NotificationManager.requestPermission()
        }
    }
}

#Preview {
    ContentView()
}
