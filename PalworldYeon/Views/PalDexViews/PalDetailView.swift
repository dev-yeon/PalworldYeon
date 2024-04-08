
import SwiftUI

struct PalDetailView: View {
    let pal: Pal

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("palicon_\(pal.palDeckNo)")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding([.bottom], 10)


                Text("No. \(pal.palDeckNo) \(pal.name)")
                    .font(.title2)
                    .padding([.top], 10)

                Divider()

                
                                   .font(.body)

            }
            .padding(.horizontal)
            .navigationBarTitle(Text(pal.name), displayMode: .inline)
        }

    }
}
