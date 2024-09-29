import SwiftUI

/// Renders the configured links and menus in-place. Designed for use inside a `List`, `Form`, or `CommandsGroup` (macOS only).
///
/// - NOTE: Make sure to call ``LinksKit.configure(providerToken:linkSections)`` upon app start or this view will not work.
public struct LinksView: View {
   public init() {}

   public var body: some View {
      LinkSectionsView(linkSections: LinksKit.linkSections)
   }
}

#if DEBUG
#Preview {
   struct Preview: View {
      init() {
         // App Links
         let ownDeveloperApps = LinkSection(entries: [
            .link(.ownApp(id: "6502914189", name: "FreemiumKit: In-App Purchases", systemImage: "cart")),
            .link(.ownApp(id: "6480134993", name: "FreelanceKit: Time Tracking", systemImage: "timer")),
         ])

         let ownConsumerApps = LinkSection(entries: [
            .link(.ownApp(id: "6472669260", name: "CrossCraft: Crossword Tests", systemImage: "puzzlepiece")),
            .link(.ownApp(id: "6477829138", name: "FocusBeats: Study Music Timer", systemImage: "music.note")),
            .link(.ownApp(id: "6587583340", name: "Pleydia Organizer: Media Renamer", systemImage: "popcorn")),
         ])

         let ownVisionApps = LinkSection(entries: [
            .link(.ownApp(id: "6479207869", name: "Guided Guest Mode: Device Demo", systemImage: "questionmark.circle")),
            .link(.ownApp(id: "6478062053", name: "Posters: Discover Movies at Home", systemImage: "movieclapper")),
         ])

         let nicosApps = LinkSection(entries: [
            .link(.friendsApp(id: "1249686798", name: "NFC.cool Tools: Tag Reader", systemImage: "tag", providerToken: "106913804")),
            .link(.friendsApp(id: "6443995212", name: "Metadata for Fastlane Tools", systemImage: "hammer", providerToken: "106913804")),
         ])

         let jansApps = LinkSection(entries: [
            .link(.friendsApp(id: "6503256642", name: "App Exhibit: Your App Showcase", systemImage: "square.grid.3x3.fill.square")),
         ])

         // Web Links
         let faqURL = URL(string: "https://example.com")!
         let privacyURL = URL(string: "https://example.com")!

         // Configure LinksKit
         LinksKit.configure(
            providerToken: "549314",
            linkSections: [
               .helpLinks(appID: "6476773066", faqURL: faqURL, supportEmail: "translatekit@fline.dev"),
               .socialMenus(
                  appLinks: .appSocialLinks(
                     platforms: [.twitter, .mastodon(instance: "mastodon.social"), .threads],
                     handle: "TranslateKit",
                     handleOverrides: [.twitter: "TranslateKitApp"]
                  ),
                  developerLinks: .developerSocialLinks(
                     platforms: [.twitter, .mastodon(instance: "iosdev.space"), .threads],
                     handle: "Jeehut"
                  )
               ),
               .appMenus(
                  ownAppLinks: [ownDeveloperApps, ownConsumerApps, ownVisionApps],
                  friendsAppLinks: [nicosApps, jansApps]
               ),
               .legalLinks(privacyURL: privacyURL)
            ]
         )
      }

      var body: some View {
         List {
            LinksView()
               .labelStyle(.titleAndIconBadge(color: .accentColor))
         }
      }
   }

   return Preview()
}
#endif
