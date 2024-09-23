import SwiftUI

struct LinksView: View {
   var body: some View {
      LinkSectionsView(linkSections: LinksKit.linkSections)
   }
}

#if DEBUG
#Preview {
   struct Preview: View {
      init() {
         // Help Section
         let helpSection = LinkSection(title: "Help", entries: [
            .link(.rateTheApp(id: "6502914189")),
            .link(.frequentlyAskedQuestions(url: URL(string: "https://freemiumkit.app/documentation/freemiumkit/faqs/")!)),
            .link(.contactDeveloper(email: "freemiumkit@fline.dev")),
         ])

         // Social Links
         let appSocialLinks = LinkSection(entries: [
            .link(.appOn(socialMedia: .twitter, username: "FreemiumKit")),
            .link(.appOn(socialMedia: .mastodonDotSocial, username: "FreemiumKit")),
            .link(.appOn(socialMedia: .threads, username: "FreemiumKit")),
         ])

         let devSocialLinks = LinkSection(entries: [
            .link(.developerOn(socialMedia: .twitter, username: "Jeehut")),
            .link(.developerOnMastodon(instance: "iosdev.space", username: "Jeehut")),
            .link(.developerOn(socialMedia: .threads, username: "Jeehut")),
         ])

         let socialSection = LinkSection(title: "Social Links", entries: [
            .menu(LinkMenu(title: "Follow the App", systemImage: "app.badge", linkSections: [appSocialLinks])),
            .menu(LinkMenu(title: "Follow the Developer", systemImage: "person", linkSections: [devSocialLinks])),
         ])

         // App Store Links
         let ownDeveloperApps = LinkSection(entries: [
            .link(.app(id: "6476773066", name: "TranslateKit: App Localizer", systemImage: "globe")),
            .link(.app(id: "6480134993", name: "FreelanceKit: Time Tracking", systemImage: "timer")),
         ])

         let ownConsumerApps = LinkSection(entries: [
            .link(.app(id: "6472669260", name: "CrossCraft: Crossword Tests", systemImage: "puzzlepiece")),
            .link(.app(id: "6477829138", name: "FocusBeats: Study Music Timer", systemImage: "music.note")),
            .link(.app(id: "6587583340", name: "Pleydia Organizer: Media Renamer", systemImage: "popcorn")),
         ])

         let ownVisionApps = LinkSection(entries: [
            .link(.app(id: "6479207869", name: "Guided Guest Mode: Device Demo", systemImage: "questionmark.circle")),
            .link(.app(id: "6478062053", name: "Posters: Discover Movies at Home", systemImage: "movieclapper")),
         ])

         let friendsApps = LinkSection(entries: [
            .link(Link(
               title: "NFC.cool", systemImage: "tag",
               url: URL(string: "https://apps.apple.com/app/apple-store/id1249686798?pt=106913804&ct=dev.fline.FreemiumKit&mt=8")!
            )),
            .link(Link(
               title: "Metadata for Fastlane Tools", systemImage: "hammer",
               url: URL(string: "https://apps.apple.com/app/apple-store/id6443995212?pt=106913804&ct=dev.fline.FreemiumKit&mt=8")!
            ))
         ])

         let appSection = LinkSection(title: "App Links", entries: [
            .menu(LinkMenu(title: "More Apps from Developer", systemImage: "plus.square.on.square", linkSections: [
               ownDeveloperApps, ownConsumerApps, ownVisionApps
            ])),
            .menu(LinkMenu(title: "Apps from Friends", systemImage: "ellipsis.viewfinder", linkSections: [friendsApps])),
         ])

         // Legal Links
         let legalSection = LinkSection(title: "Legal", entries: [
            .link(.appStoreTermsAndConditions()),
            .link(.privacyPolicy(url: URL(string: "https://fline.dev/app-privacy-analytics-en/")!))
         ])

         // Configure LinksKit
         LinksKit.configure(publisherToken: "549314", linkSections: [helpSection, socialSection, appSection, legalSection])
      }

      var body: some View {
         List {
            LinksView()
         }
      }
   }

   return Preview()
}
#endif
