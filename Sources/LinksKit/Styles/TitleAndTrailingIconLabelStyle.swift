import SwiftUI

/// A custom `LabelStyle` that displays the title with an icon trailing at the end.
///
/// This style is useful for creating labels with a trailing icon,
/// commonly used in list items or menu entries where you want to emphasize the trailing icon.
public struct TitleAndTrailingIconLabelStyle: LabelStyle {
   /// Creates a view representing the body of a label.
   ///
   /// - Parameter configuration: The properties of the label.
   /// - Returns: A view that represents the label with the custom style applied.
   ///
   /// This method creates a horizontal stack with the title, followed by a spacer,
   /// and then the icon at the trailing edge.
   public func makeBody(configuration: Configuration) -> some View {
      HStack {
         configuration.title

         Spacer()

         configuration.icon
      }
   }
}

extension LabelStyle where Self == TitleAndTrailingIconLabelStyle {
   /// A static property that returns a `TitleAndTrailingIconLabelStyle` instance.
   ///
   /// This property provides a convenient way to apply the custom label style.
   ///
   /// Example usage:
   /// ```
   /// List {
   ///     Label("Profile", systemImage: "person.circle")
   ///         .labelStyle(.titleAndTrailingIcon)
   ///     Label("Settings", systemImage: "gear")
   ///         .labelStyle(.titleAndTrailingIcon)
   ///     Label("Logout", systemImage: "arrow.right.square")
   ///         .labelStyle(.titleAndTrailingIcon)
   /// }
   /// ```
   public static var titleAndTrailingIcon: TitleAndTrailingIconLabelStyle { TitleAndTrailingIconLabelStyle() }
}

#if DEBUG
#Preview {
   Form {
      Section("Label Styles: .labelStyle(...)") {
         Label(".titleAndIcon (SwiftUI Default)", systemImage: "globe")
            .labelStyle(.titleAndIcon)

         Label(".titleAndTrailingIcon", systemImage: "globe")
            .labelStyle(.titleAndTrailingIcon)

         Label(".titleAndIconBadge(color: .red)", systemImage: "globe")
            .labelStyle(.titleAndIconBadge(color: .red))

         Label(".titleAndTrailingIconBadge(color: .red)", systemImage: "globe")
            .labelStyle(.titleAndTrailingIconBadge(color: .red))
      }
   }
}
#endif
