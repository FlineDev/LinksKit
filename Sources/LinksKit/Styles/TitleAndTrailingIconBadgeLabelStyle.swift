import SwiftUI

/// A custom `LabelStyle` that displays the title with a colored icon badge trailing at the end.
///
/// This style is useful for creating labels with a trailing colored icon badge,
/// commonly used in list items or settings menus where you want to emphasize the trailing icon.
public struct TitleAndTrailingIconBadgeLabelStyle: LabelStyle {
   /// The color of the icon badge.
   let color: Color

   /// Creates a view representing the body of a label.
   ///
   /// - Parameter configuration: The properties of the label.
   /// - Returns: A view that represents the label with the custom style applied.
   ///
   /// This method creates a horizontal stack with the title, followed by a spacer,
   /// and then a colored badge containing the icon. The badge size adjusts to match the height of the label.
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
   /// Creates a `TitleAndTrailingIconBadgeLabelStyle` with the specified badge color.
   ///
   /// This static method provides a convenient way to create and apply the custom label style.
   ///
   /// - Parameter color: The color to be used for the icon badge.
   /// - Returns: A `TitleAndTrailingIconBadgeLabelStyle` instance with the specified color.
   ///
   /// Example usage:
   /// ```
   /// VStack {
   ///     Label("Wi-Fi", systemImage: "wifi")
   ///         .labelStyle(.titleAndTrailingIconBadge(color: .blue))
   ///     Label("Bluetooth", systemImage: "bluetooth")
   ///         .labelStyle(.titleAndTrailingIconBadge(color: .green))
   ///     Label("Airplane Mode", systemImage: "airplane")
   ///         .labelStyle(.titleAndTrailingIconBadge(color: .orange))
   /// }
   /// ```
   public static func titleAndTrailingIconBadge(color: Color) -> TitleAndTrailingIconBadgeLabelStyle {
      TitleAndTrailingIconBadgeLabelStyle(color: color)
   }
}

#if DEBUG
#Preview {
   Form {
      Section("Label Styles: .labelStyle(...)") {
         Label(".titleAndIcon (SwiftUI Default)", systemImage: "magnifyingglass")
            .labelStyle(.titleAndIcon)

         Label(".titleAndTrailingIcon", systemImage: "magnifyingglass")
            .labelStyle(.titleAndTrailingIcon)

         Label(".titleAndIconBadge(color: .red)", systemImage: "magnifyingglass")
            .labelStyle(.titleAndIconBadge(color: .red))

         Label(".titleAndTrailingIconBadge(color: .red)", systemImage: "magnifyingglass")
            .labelStyle(.titleAndTrailingIconBadge(color: .red))
      }
   }
}
#endif
