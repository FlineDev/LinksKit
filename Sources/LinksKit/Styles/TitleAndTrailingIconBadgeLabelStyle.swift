import SwiftUI

public struct TitleAndTrailingIconBadgeLabelStyle: LabelStyle {
   let color: Color

   public func makeBody(configuration: Configuration) -> some View {
      GeometryReader { proxy in
         HStack {
            configuration.title

            Spacer()

            Group {
               RoundedRectangle(cornerRadius: 8)
                  .fill(self.color)
                  .overlay(configuration.icon.foregroundStyle(.white).font(.body))
                  .padding(4)
            }
            .frame(width: proxy.size.height, height: proxy.size.height)
            .padding(.trailing, -8)
         }
      }
   }
}

extension LabelStyle where Self == TitleAndTrailingIconBadgeLabelStyle {
   public static func titleAndTrailingIconBadge(color: Color) -> TitleAndTrailingIconBadgeLabelStyle {
      TitleAndTrailingIconBadgeLabelStyle(color: color)
   }
}

#if DEBUG
#Preview {
   Form {
      Label("Hello World", systemImage: "magnifyingglass")
         .labelStyle(.iconOnly)
      Label("Hello World", systemImage: "magnifyingglass")
         .labelStyle(.titleAndIcon)
      Label("Hello World", systemImage: "magnifyingglass")
         .labelStyle(.titleOnly)
      Label("Hello World", systemImage: "magnifyingglass")
         .labelStyle(.titleAndTrailingIconBadge(color: .red))
   }
}
#endif
