import SwiftUI

/// A custom `LabelStyle` that displays the icon as a colored badge with the title next to it. This resembles the same look as Apple uses in the Settings app.
///
/// This style is useful for creating visually appealing labels with a colored icon badge, commonly used in list items or navigation elements.
public struct TitleAndIconBadgeLabelStyle: LabelStyle {
   /// The color of the icon badge.
   let color: Color

   /// Creates a view representing the body of a label.
   ///
   /// - Parameter configuration: The properties of the label.
   /// - Returns: A view that represents the label with the custom style applied.
   ///
   /// This method creates a horizontal stack with a colored badge containing the icon, followed by the title. The badge size adjusts to match the height of the label.
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
   /// Creates a `TitleAndIconBadgeLabelStyle` with the specified badge color. This resembles the same look as Apple uses in the Settings app.
   ///
   /// This static method provides a convenient way to create and apply the custom label style.
   ///
   /// - Parameter color: The color to be used for the icon badge.
   /// - Returns: A `TitleAndIconBadgeLabelStyle` instance with the specified color.
   ///
   /// Example usage:
   /// ```
   /// VStack {
   ///     Label("Profile", systemImage: "person")
   ///         .labelStyle(.titleAndIconBadge(color: .green))
   ///     Label("Messages", systemImage: "message")
   ///         .labelStyle(.titleAndIconBadge(color: .blue))
   /// }
   /// ```
   public static func titleAndIconBadge(color: Color) -> TitleAndIconBadgeLabelStyle {
      TitleAndIconBadgeLabelStyle(color: color)
   }
}

#if DEBUG
#Preview {
   Form {
      Section("Label Styles: .labelStyle(...)") {
         Label(String(".titleAndIcon (SwiftUI Default)"), systemImage: "magnifyingglass")
            .labelStyle(.titleAndIcon)

         Label(String(".titleAndTrailingIcon"), systemImage: "magnifyingglass")
            .labelStyle(.titleAndTrailingIcon)

         Label(String(".titleAndIconBadge(color: .red)"), systemImage: "magnifyingglass")
            .labelStyle(.titleAndIconBadge(color: .red))

         Label(String(".titleAndTrailingIconBadge(color: .red)"), systemImage: "magnifyingglass")
            .labelStyle(.titleAndTrailingIconBadge(color: .red))
      }
      .textCase(.none)
   }
}
#endif
