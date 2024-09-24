import SwiftUI

public struct TitleAndIconBadgeLabelStyle: LabelStyle {
   let color: Color

   public func makeBody(configuration: Configuration) -> some View {
      GeometryReader { proxy in
         HStack {
            Group {
               RoundedRectangle(cornerRadius: 8)
                  .fill(self.color)
                  .overlay(configuration.icon.foregroundStyle(.white).font(.body))
                  .padding(4)
            }
            .frame(width: proxy.size.height, height: proxy.size.height)
            .padding(.leading, -8)

            configuration.title
         }
      }
   }
}

extension LabelStyle where Self == TitleAndIconBadgeLabelStyle {
   public static func titleAndIconBadge(color: Color) -> TitleAndIconBadgeLabelStyle {
      TitleAndIconBadgeLabelStyle(color: color)
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
         .labelStyle(.titleAndIconBadge(color: .red))
   }
}
#endif
