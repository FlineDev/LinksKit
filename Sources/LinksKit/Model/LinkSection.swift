import SwiftUI

public struct LinkSection: Identifiable {
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

   public init(title: String? = nil, entries: [Entry]) {
      self.title = title
      self.entries = entries
   }
}

extension LinkSection {
   public static func helpLinks(appID: String, faqURL: URL, supportEmail: String) -> Self {
      LinkSection(
         title: String(localized: "Help", bundle: .module),
         entries: [
            .link(.rateTheApp(id: appID)),
            .link(.frequentlyAskedQuestions(url: faqURL)),
            .link(.contactSupport(email: supportEmail)),
         ]
      )
   }

   public static func appSocialLinks(
      platforms: [SocialPlatform],
      handle: String,
      handleOverrides: [SocialPlatform: String] = [:]
   ) -> Self {
      LinkSection(entries: platforms.map { .link(.appOn(socialPlatform: $0, handle: handleOverrides[$0] ?? handle)) })
   }

   public static func developerSocialLinks(
      platforms: [SocialPlatform],
      handle: String,
      handleOverrides: [SocialPlatform: String] = [:]
   ) -> Self {
      LinkSection(entries: platforms.map { .link(.developerOn(socialPlatform: $0, handle: handleOverrides[$0] ?? handle)) })
   }

   public static func socialMenus(appLinks: LinkSection, developerLinks: LinkSection) -> Self {
      LinkSection(
         title: String(localized: "Social Links", bundle: .module),
         entries: [
            .menu(LinkMenu(title: "Follow the App", systemImage: "app.badge", linkSections: [appLinks])),
            .menu(LinkMenu(title: "Follow the Developer", systemImage: "person", linkSections: [developerLinks])),
         ]
      )
   }

   public static func appMenus(ownAppLinks: [LinkSection], friendsAppLinks: [LinkSection]) -> Self {
      LinkSection(
         title: "App Links",
         entries: [
            .menu(LinkMenu(title: "More Apps from Developer", systemImage: "plus.square.on.square", linkSections: ownAppLinks)),
            .menu(LinkMenu(title: "Apps from Friends", systemImage: "hand.thumbsup", linkSections: friendsAppLinks)),
         ]
      )
   }

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
