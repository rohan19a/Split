import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: 20) {
            if let profileImage = viewModel.profileImage {
                profileImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }

            Text(viewModel.userName)
                .font(.title)

            HStack {
                Text("App user since \(viewModel.appUserSince)")
                Spacer()
                Text("\(viewModel.completedTransactions) completed transactions")
            }
            .foregroundColor(.gray)

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("Reviews")
                    .font(.title2)

                if viewModel.reviews.isEmpty {
                    Text("No reviews yet.")
                } else {
                    ForEach(viewModel.reviews) { review in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(review.text)
                            Text("By \(review.reviewerName) on \(viewModel.formatDate(review.date))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.loadProfile()
        }
    }
}

class ProfileViewModel: ObservableObject {
    @Published var profileImage: Image?
    @Published var userName: String = ""
    @Published var appUserSince: String = ""
    @Published var completedTransactions: Int = 0
    @Published var reviews: [Review] = []

    private let db = Firestore.firestore()
    private let currentUser = Auth.auth().currentUser

    func loadProfile() {
        guard let currentUser = currentUser else { return }

        // Load user information
        db.collection("users").document(currentUser.uid).getDocument { snapshot, error in
            guard let document = snapshot?.data() else {
                print("Error fetching user document: \(error!)")
                return
            }

            let user = try? Firestore.Decoder().decode(User.self, from: document)

            DispatchQueue.main.async {
                self.profileImage = user?.profileImageUrl != nil ? Image(systemName: "person.circle.fill") : nil
                self.userName = user?.name ?? ""
                self.appUserSince = self.formatDate(user?.appUserSince ?? Date())
                self.completedTransactions = user?.completedTransactions ?? 0
            }
        }

        // Load user reviews
        db.collection("reviews").whereField("userId", isEqualTo: currentUser.uid).getDocuments { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching review documents: \(error!)")
                return
            }

            let reviews = documents.compactMap { document -> Review? in
                let data = document.data()
                let reviewerName = data["reviewerName"] as! String
                let text = data["text"] as! String
                let date = (data["date"] as! Timestamp).dateValue()

                return Review(reviewerName
