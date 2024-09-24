import SwiftUI

public struct TitleAndTrailingIconLabelStyle: LabelStyle {
   public func makeBody(configuration: Configuration) -> some View {
      HStack {
         configuration.title

         Spacer()

         configuration.icon
      }
   }
}

extension LabelStyle where Self == TitleAndTrailingIconLabelStyle {
   public static var titleAndTrailingIcon: TitleAndTrailingIconLabelStyle { TitleAndTrailingIconLabelStyle() }
}

#if DEBUG
#Preview {
   Form {
      Label("Hello World", systemImage: "globe")
         .labelStyle(.iconOnly)
      Label("Hello World", systemImage: "globe")
         .labelStyle(.titleAndIcon)
      Label("Hello World", systemImage: "globe")
         .labelStyle(.titleOnly)
      Label("Hello World", systemImage: "globe")
         .labelStyle(.titleAndTrailingIcon)
   }
}
#endif
