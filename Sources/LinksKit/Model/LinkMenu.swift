import Foundation

/// Represents a menu containing multiple link sections.
///
/// Use this struct to create grouped links that can be displayed in a submenu.
public struct LinkMenu: Identifiable {
   public let id: UUID = UUID()
   let title: String
   let systemImage: String
   let linkSections: [LinkSection]

   /// Creates a new LinkMenu instance.
   ///
   /// - Parameters:
   ///   - title: The display title for the menu.
   ///   - systemImage: The name of the system image to use as an icon.
   ///   - linkSections: An array of LinkSection instances to include in the menu.
   ///
   /// Example usage:
   /// ```swift
   /// let customMenu = LinkMenu(
   ///     title: "Social Media",
   ///     systemImage: "network",
   ///     linkSections: [
   ///         LinkSection(entries: [
   ///             .link(Link.followUsOn(socialPlatform: .twitter, handle: "YourAppHandle")),
   ///             .link(Link.followUsOn(socialPlatform: .instagram, handle: "YourAppHandle"))
   ///         ])
   ///     ]
   /// )
   /// ```
   public init(title: String, systemImage: String, linkSections: [LinkSection]) {
      self.title = title
      self.systemImage = systemImage
      self.linkSections = linkSections
   }
}

extension LinkMenu {
   /// Creates a menu for following the app on various social media platforms.
   ///
   /// - Parameter links: An array of Link instances for different social media platforms.
   /// - Returns: A LinkMenu instance for following the app.
   ///
   /// Example usage:
   /// ```swift
   /// let followAppMenu = LinkMenu.followTheApp(links: [
   ///     Link.followUsOn(socialPlatform: .twitter, handle: "YourAppHandle"),
   ///     Link.followUsOn(socialPlatform: .instagram, handle: "YourAppHandle")
   /// ])
   /// ```
   public static func followTheApp(links: [Link]) -> Self {
      LinkMenu(
         title: String(localized: "Follow the App", bundle: .module),
         systemImage: "app.badge",
         linkSections: [LinkSection(entries: links.map(LinkSection.Entry.link))]
      )
   }

   /// Creates a menu for following the developer on various social media platforms.
   ///
   /// - Parameter links: An array of Link instances for different social media platforms.
   /// - Returns: A LinkMenu instance for following the developer.
   ///
   /// Example usage:
   /// ```swift
   /// let followDevMenu = LinkMenu.followTheDeveloper(links: [
   ///     Link.developerOn(socialPlatform: .twitter, handle: "YourDevHandle"),
   ///     Link.developerOn(socialPlatform: .github, handle: "YourDevHandle")
   /// ])
   /// ```
   public static func followTheDeveloper(links: [Link]) -> Self {
      LinkMenu(
         title: String(localized: "Follow the Developer", bundle: .module),
         systemImage: "person",
         linkSections: [LinkSection(entries: links.map(LinkSection.Entry.link))]
      )
   }

   /// Creates a menu for showcasing more apps from the developer.
   ///
   /// - Parameter linkSections: An array of LinkSection instances, each potentially representing a category of apps.
   /// - Returns: A LinkMenu instance for more apps from the developer.
   ///
   /// Example usage:
   /// ```swift
   /// let moreAppsMenu = LinkMenu.moreAppsFromDeveloper(linkSections: [
   ///     LinkSection(title: "Productivity Apps", entries: [
   ///         .link(Link.ownApp(id: "1234567890", name: "Todo Master", systemImage: "checklist")),
   ///         .link(Link.ownApp(id: "0987654321", name: "Focus Timer", systemImage: "timer"))
   ///     ]),
   ///     LinkSection(title: "Entertainment Apps", entries: [
   ///         .link(Link.ownApp(id: "1122334455", name: "Puzzle Quest", systemImage: "puzzle"))
   ///     ])
   /// ])
   /// ```
   public static func moreAppsFromDeveloper(linkSections: [LinkSection]) -> Self {
      LinkMenu(
         title: String(localized: "More apps from Developer", bundle: .module),
         systemImage: "plus.square.on.square",
         linkSections: linkSections
      )
   }

   /// Creates a menu for showcasing related apps that users might like.
   ///
   /// - Parameter linkSections: An array of LinkSection instances, each potentially representing a category of related apps.
   /// - Returns: A LinkMenu instance for related apps.
   ///
   /// Example usage:
   /// ```swift
   /// let relatedAppsMenu = LinkMenu.relatedAppsYouMightLike(linkSections: [
   ///     LinkSection(title: "Similar Productivity Apps", entries: [
   ///         .link(Link.friendsApp(id: "2233445566", name: "Task Pro", systemImage: "list.bullet", providerToken: "654321")),
   ///         .link(Link.friendsApp(id: "3344556677", name: "Time Tracker", systemImage: "stopwatch", providerToken: "765432"))
   ///     ])
   /// ])
   /// ```
   public static func relatedAppsYouMightLike(linkSections: [LinkSection]) -> Self {
      LinkMenu(
         title: String(localized: "Related apps you might Like", bundle: .module),
         systemImage: "star.square.on.square",
         linkSections: linkSections
      )
   }
}
