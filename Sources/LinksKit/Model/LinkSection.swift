import SwiftUI

/// Represents a section of links or submenus.
public struct LinkSection: Identifiable {
   /// Represents an entry in a LinkSection, which can be either a Link or a LinkMenu.
   public enum Entry: Identifiable {
      case link(Link)
      case menu(LinkMenu)

      public var id: UUID {
         switch self {
         case .link(let link): link.id
         case .menu(let linkMenu): linkMenu.id
         }
      }
   }

   public let id: UUID = UUID()
   let title: String?
   let entries: [Entry]

   /// Creates a new LinkSection instance.
   ///
   /// - Parameters:
   ///   - title: An optional title for the section.
   ///   - entries: An array of Entry instances (links or menus) to include in the section.
   ///
   /// Example usage:
   /// ```swift
   /// let customSection = LinkSection(
   ///     title: "Custom Links",
   ///     entries: [
   ///         .link(Link(title: "Our Website", systemImage: "globe", url: URL(string: "https://www.example.com")!)),
   ///         .menu(LinkMenu.followTheApp(links: [
   ///             Link.followUsOn(socialPlatform: .twitter, handle: "YourAppHandle")
   ///         ]))
   ///     ]
   /// )
   /// ```
   public init(title: String? = nil, entries: [Entry]) {
      self.title = title
      self.entries = entries
   }
}

extension LinkSection {
   /// Creates a section with help-related links.
   ///
   /// - Parameters:
   ///   - appID: The App Store ID of your app.
   ///   - faqURL: An optional URL to your FAQ page.
   ///   - supportEmail: The email address for support inquiries.
   /// - Returns: A LinkSection instance with help links.
   ///
   /// Example usage:
   /// ```swift
   /// let helpSection = LinkSection.helpLinks(
   ///     appID: "1234567890",
   ///     faqURL: URL(string: "https://www.example.com/faq"),
   ///     supportEmail: "support@example.com"
   /// )
   /// ```
   public static func helpLinks(appID: String, faqURL: URL? = nil, supportEmail: String) -> Self {
      if let faqURL {
         LinkSection(
            title: String(localized: "Help", bundle: .module),
            entries: [
               .link(.rateTheApp(id: appID)),
               .link(.frequentlyAskedQuestions(url: faqURL)),
               .link(.contactSupport(email: supportEmail)),
            ]
         )
      } else {
         LinkSection(
            title: String(localized: "Help", bundle: .module),
            entries: [
               .link(.rateTheApp(id: appID)),
               .link(.contactSupport(email: supportEmail)),
            ]
         )
      }
   }

   /// Creates a section with social media links for the app.
   ///
   /// - Parameters:
   ///   - platforms: An array of SocialPlatform instances to include.
   ///   - handle: The default handle or username for the app on these platforms.
   ///   - handleOverrides: A dictionary to specify different handles for specific platforms.
   /// - Returns: A LinkSection instance with app social media links.
   ///
   /// Example usage:
   /// ```swift
   /// let appSocialSection = LinkSection.appSocialLinks(
   ///     platforms: [.twitter, .instagram, .facebook],
   ///     handle: "YourAppHandle",
   ///     handleOverrides: [.twitter: "YourAppTwitter"]
   /// )
   /// ```
   public static func appSocialLinks(
      title: String? = nil,
      platforms: [SocialPlatform],
      handle: String,
      handleOverrides: [SocialPlatform: String] = [:]
   ) -> Self {
      LinkSection(title: title, entries: platforms.map { .link(.appOn(socialPlatform: $0, handle: handleOverrides[$0] ?? handle)) })
   }

   /// Creates a section with social media links for the developer.
   ///
   /// - Parameters:
   ///   - platforms: An array of SocialPlatform instances to include.
   ///   - handle: The default handle or username for the developer on these platforms.
   ///   - handleOverrides: A dictionary to specify different handles for specific platforms.
   /// - Returns: A LinkSection instance with developer social media links.
   ///
   /// Example usage:
   /// ```swift
   /// let devSocialSection = LinkSection.developerSocialLinks(
   ///     platforms: [.twitter, .github, .linkedin],
   ///     handle: "YourDevHandle",
   ///     handleOverrides: [.github: "YourGitHubUsername"]
   /// )
   /// ```
   public static func developerSocialLinks(
      title: String? = nil,
      platforms: [SocialPlatform],
      handle: String,
      handleOverrides: [SocialPlatform: String] = [:]
   ) -> Self {
      LinkSection(title: title, entries: platforms.map { .link(.developerOn(socialPlatform: $0, handle: handleOverrides[$0] ?? handle)) })
   }

   /// Creates a section with social media menus for both the app and the developer.
   ///
   /// - Parameters:
   ///   - appLinks: A LinkSection containing app social media links.
   ///   - developerLinks: A LinkSection containing developer social media links.
   /// - Returns: A LinkSection instance with social media menus.
   ///
   /// Example usage:
   /// ```swift
   /// let socialMenusSection = LinkSection.socialMenus(
   ///     appLinks: LinkSection.appSocialLinks(platforms: [.twitter, .instagram], handle: "YourAppHandle"),
   ///     developerLinks: LinkSection.developerSocialLinks(platforms: [.twitter, .github], handle: "YourDevHandle")
   /// )
   /// ```
   public static func socialMenus(appLinks: LinkSection, developerLinks: LinkSection) -> Self {
      LinkSection(
         title: String(localized: "Social Links", bundle: .module),
         entries: [
            .menu(LinkMenu(title: "Follow the App", systemImage: "app.badge", linkSections: [appLinks])),
            .menu(LinkMenu(title: "Follow the Developer", systemImage: "person", linkSections: [developerLinks])),
         ]
      )
   }

   /// Creates a section with menus for the developer's own apps and friends' apps.
   ///
   /// - Parameters:
   ///   - ownAppLinks: An array of LinkSection instances for the developer's own apps.
   ///   - friendsAppLinks: An array of LinkSection instances for friends' apps.
   /// - Returns: A LinkSection instance with app menus.
   ///
   /// Example usage:
   /// ```swift
   /// let appMenusSection = LinkSection.appMenus(
   ///     ownAppLinks: [
   ///         LinkSection(title: "Productivity", entries: [
   ///             .link(Link.ownApp(id: "1234567890", name: "Todo Master", systemImage: "checklist"))
   ///         ])
   ///     ],
   ///     friendsAppLinks: [
   ///         LinkSection(title: "Games", entries: [
   ///             .link(Link.friendsApp(id: "0987654321", name: "Puzzle Quest", systemImage: "puzzle", providerToken: "123456"))
   ///         ])
   ///     ]
   /// )
   /// ```
   public static func appMenus(ownAppLinks: [LinkSection], friendsAppLinks: [LinkSection]) -> Self {
      LinkSection(
         title: "App Links",
         entries: [
            .menu(LinkMenu(title: "More Apps from Developer", systemImage: "plus.square.on.square", linkSections: ownAppLinks)),
            .menu(LinkMenu(title: "Apps from Friends", systemImage: "hand.thumbsup", linkSections: friendsAppLinks)),
         ]
      )
   }

   /// Creates a section with legal links, including App Store Terms and Conditions and Privacy Policy.
   ///
   /// - Parameter privacyURL: The URL to your privacy policy.
   /// - Returns: A LinkSection instance with legal links.
   ///
   /// Example usage:
   /// ```swift
   /// let legalSection = LinkSection.legalLinks(privacyURL: URL(string: "https://www.example.com/privacy")!)
   /// ```
   public static func legalLinks(privacyURL: URL) -> Self {
      LinkSection(
         title: String(localized: "Legal", bundle: .module),
         entries: [
            .link(.appStoreTermsAndConditions()),
            .link(.privacyPolicy(url: privacyURL)),
         ]
      )
   }
}
