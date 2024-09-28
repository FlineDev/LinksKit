[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFlineDev%2FLinksKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/FlineDev/LinksKit)

# LinksKit

Apple requires that every app must link to their privacy policy and additionally to the terms of use (if it has in-app purchases) as part of their guidelines. Most apps solve this by adding a "Links" section somewhere in their apps settings. And while at it, they also add some more links like to rate the app, to their FAQ or to get support. This package comes with all these common things built-in so you can save a lot of time while setting up these kinds of screens. And it even supports the most common place on macOS as well: the help menu!

## Usage

Basically, you just need to `import LinksKit` and place a `LinksView()` somewhere inside a `List` or `Form` view. It will automatically create all the sections you need. But for the `LinksView` to know what links to present, you need to do some setup first:

### Minimal Setup

For the minimal variant which contains only the legal links and the app rating & contact email, you can add this code to your app entry point:

```swift
import SwiftUI

@main
struct YourApp: App {
   init() {
      // other setup code
      
      LinksKit.configure(
         providerToken: "123456",
         linkSections: [
            .helpLinks(appID: "123456789", supportEmail: "support@example.com"),
            .legalLinks(privacyURL: URL(string: "https://example.com")!)
         ]
      )
   }
   
   var body: some Scene {
      // your UI code
   }
}
```

> Tip: The `providerToken` is the `pt` query parameter in the campaign link of your app (e.g. ` https://apps.apple.com/app/apple-store/id123456789?**pt=123456**&ct=test1234&mt=8`). If you are new to campaign links, make sure to learn about them [here](https://developer.apple.com/help/app-store-connect/view-app-analytics/manage-campaigns) – they basically help you understand where people have discovered your app. Note that you don't have to create campaign links using App Store Connect over and over again – the `providerToken` is the same for all your apps and you can change the `campaignToken` (`ct` query parameter) to anything you like. LinksKit sends your apps Bundle ID as the campaign token by default, that's why you don't need to set it up.

> Note: LinksKit automatically adds the link to Apples terms of use for apps with in-app purchases to the `.legalLinks` section – no action needed. It just works. 🚀

### Optional Extras

LinksKit is fully customizable but comes also with built-in extras for your convenience:

* `.helpLinks` also accepts an optional `faqURL` parameter if you have a link for common questions
* `.socialMenus(appLinks:developerLinks:)` is for linking to your and/or your apps socials
* `.appMenus(ownAppLinks:friendsAppLinks:)` is for linking to your other apps and/or some friends apps

A real-world example from my app [TranslateKit](https://apps.apple.com/app/apple-store/id6476773066?pt=549314&ct=github.com&mt=8) that makes use of all these extras looks like this:

```swift
init() {
   // other setup code

   self.configureLinksKit()
}

func configureLinksKit() {
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
      .link(.friendsApp(id: "1249686798", name: "NFC.cool Tools: Tag Reader", systemImage: "tag", publisherToken: "106913804")),
      .link(.friendsApp(id: "6443995212", name: "Metadata for Fastlane Tools", systemImage: "hammer", publisherToken: "106913804")),
   ])

   let jansApps = LinkSection(entries: [
      .link(.friendsApp(id: "6503256642", name: "App Exhibit: Your App Showcase", systemImage: "square.grid.3x3.fill.square")),
   ])

   // Configure LinksKit
   LinksKit.configure(
      publisherToken: "549314",
      linkSections: [
         .helpLinks(appID: "6476773066", faqURL: Constants.faqURL, supportEmail: "translatekit@fline.dev"),
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
         .legalLinks(privacyURL: Constants.privacyPolicyURL)
      ]
   )
}
```

> Note: The reason `.ownApp` and `.friendsApp` are named differently is because LinksKit will automatically add your `providerToken` to your own apps while you need to pass your friends `publisherToken` using the optional parameter in case you know it.

### Custom Links & Menus

On top of the built-in convenience helpers `.helpLinks`, `.socialMenus`, `.appMenus`, and `.legalLinks`, you can also create own complete custom `LinkSection` instances and pass your own links. You can even nest them! For example, `.appMenus` is just a convenience for this equivalent `LinkSection`:

```swift
LinkSection(
   title: "App Links",
   entries: [
      .menu(LinkMenu(
         title: "More Apps from Developer",
         systemImage: "plus.square.on.square",
         linkSections: [ownDeveloperApps, ownConsumerApps, ownVisionApps]
      )),
      .menu(LinkMenu(
         title: "Apps from Friends",
         systemImage: "hand.thumbsup",
         linkSections: [nicosApps, jansApps]
      )),
   ]
)
```

The `entries` parameter accepts one of `.menu(LinkMenu)` or `.link(Link)` and you can nest as many levels as SwiftUI supports (`.menu` becomes a `Menu` view, `.link` a `Button`).

### View Setup

For all platforms except macOS, it's common to have a settings screen with a `Form` or `List`. Just add `LinksView()` inside it like so:

```swift
import SwiftUI

struct SettingsView: View {
   var body: some View {
      Form {
         // other sections/views like a paid status view or app settings
         
         #if !os(macOS)
         LinksView()
         #endif
      }
   }
}
```

That's it – really! You can even remove the `#if !os(macOS)` check if your app doesn't natively support macOS.

The result on non-Mac platforms should look like this:

<img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/PhoneSettings.jpeg" />


When targeting macOS, it's more common to put links into the `Help` menu bar instead of the Settings screen. To do this just add `LinksView()` to your commands menu like so:

```swift
import SwiftUI

@main
struct YourApp: App {
   var body: some Scene {
      WindowGroup {
         // your UI code
      }
      .commands {
         CommandGroup(replacing: .help) {
            LinksView()
               .labelStyle(.titleAndIcon)
         }
      }
   }
}
```

You need to pass `.labelStyle(.titleAndIcon)` to see the icons here, because by default, the menu entries use the `.titleOnly` label style.

The result on Mac will look something like this:

<img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/MacHelpMenu.jpeg" />

### Localization

All texts that are built-in to LinksKit are pre-localized to all [the same ~40 languages supported by iOS](https://www.apple.com/ios/feature-availability/#system-language-system-language). No action needed. If you need more languages, please open an issue on GitHub – I'm happy to add more.

If you want to localize any other text you pass to LinksKit APIs such as the names of your apps, just use `String(localized: "your-text")` and localize the text in your apps String Catalog as usual.

## Showcase

I extracted this library from my following Indie apps (rate them with 5 stars to support me!):

<table>
  <tr>
    <th>App Icon</th>
    <th>App Name & Description</th>
    <th>Supported Platforms</th>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6476773066?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/TranslateKit.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6476773066?pt=549314&ct=github.com&mt=8">
        <strong>TranslateKit: App Localizer</strong>
      </a>
      <br />
      Simple drag & drop translation of String Catalog files with support for multiple translation services & smart correctness checks.
    </td>
    <td>Mac</td>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6587583340?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/PleydiaOrganizer.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6587583340?pt=549314&ct=github.com&mt=8">
        <strong>Pleydia Organizer: Movie & Series Renamer</strong>
      </a>
      <br />
      Simple, fast, and smart media management for your Movie, TV Show and Anime collection.
    </td>
    <td>Mac</td>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6502914189?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/FreemiumKit.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6502914189?pt=549314&ct=github.com&mt=8">
        <strong>FreemiumKit: In-App Purchases</strong>
      </a>
      <br />
      Simple In-App Purchases and Subscriptions for Apple Platforms: Automation, Paywalls, A/B Testing, Live Notifications, PPP, and more.
    </td>
    <td>iPhone, iPad, Mac, Vision</td>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6480134993?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/FreelanceKit.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6480134993?pt=549314&ct=github.com&mt=8">
        <strong>FreelanceKit: Time Tracking</strong>
      </a>
      <br />
      Simple & affordable time tracking with a native experience for all  devices. iCloud sync & CSV export included.
    </td>
    <td>iPhone, iPad, Mac, Vision</td>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6472669260?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/CrossCraft.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6472669260?pt=549314&ct=github.com&mt=8">
        <strong>CrossCraft: Custom Crosswords</strong>
      </a>
      <br />
      Create themed & personalized crosswords. Solve them yourself or share them to challenge others.
    </td>
    <td>iPhone, iPad, Mac, Vision</td>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6477829138?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/FocusBeats.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6477829138?pt=549314&ct=github.com&mt=8">
        <strong>FocusBeats: Pomodoro + Music</strong>
      </a>
      <br />
      Deep Focus with proven Pomodoro method & select Apple Music playlists & themes. Automatically pauses music during breaks.
    </td>
    <td>iPhone, iPad, Mac, Vision</td>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6479207869?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/GuidedGuestMode.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6479207869?pt=549314&ct=github.com&mt=8">
        <strong>Guided Guest Mode</strong>
      </a>
      <br />
      Showcase Apple Vision Pro effortlessly to friends & family. Customizable, easy-to-use guides for everyone!
    </td>
    <td>Vision</td>
  </tr>
  <tr>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6478062053?pt=549314&ct=github.com&mt=8">
        <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/Apps/Posters.webp" width="64" />
      </a>
    </td>
    <td>
      <a href="https://apps.apple.com/app/apple-store/id6478062053?pt=549314&ct=github.com&mt=8">
        <strong>Posters: Discover Movies at Home</strong>
      </a>
      <br />
      Auto-updating & interactive posters for your home with trailers, showtimes, and links to streaming services.
    </td>
    <td>Vision</td>
  </tr>
</table>
