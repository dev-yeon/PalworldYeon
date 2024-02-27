import SwiftUI

struct ChildPickerView: View {
    @ObservedObject var viewModel: PalViewModel // viewModel을 ObservedObject로 선언
    @State private var selectedChildId: Int? // @State는 구조체 내부에 선언

    var body: some View {
        VStack {
            // 자식 선택을 위한 Picker View
            Picker("자식 선택", selection: $selectedChildId) {
                ForEach(viewModel.pals) { pal in
                    Text(pal.name).tag(pal.id as Int?) // 'as Int?'를 제거하고 올바른 타입 사용을 권장
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
        // 다른 컴포넌트들...
    }
}

// SwiftUI 프리뷰
struct ChildPickerView_Previews: PreviewProvider {
    static var previews: some View {
        // viewModel의 인스턴스를 생성하여 프리뷰에 전달
        ChildPickerView(viewModel: PalViewModel())
    }
}
