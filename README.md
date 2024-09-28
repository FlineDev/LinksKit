![LinksKit Logo](https://github.com/FlineDev/LinksKit/blob/main/Images/Logo.png?raw=true)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFlineDev%2FLinksKit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/FlineDev/LinksKit)

# LinksKit

Every app on the App Store must provide essential links like a privacy policy and, if applicable, terms of use (for in-app purchases) to comply with Apple's guidelines. Many apps handle this by adding a "Links" section in their settings, including additional helpful links like app ratings, FAQs, and support options.

That's where LinksKit comes in: it offers **a simple, ready-to-use solution to handle all these common links**, saving you a ton of time. Whether it's legal, help, or app promotion links, LinksKit covers it. And for macOS, it even supports adding these links right into the **Help** menu!

iOS Example             |  macOS Example
------------------------|-------------------------
<img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/PhoneSettings.jpeg">  |  <img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/MacHelpMenu.jpeg">

## Usage

Getting started with LinksKit is easy. After adding the package to your project, simply `import LinksKit` and place a `LinksView()` inside a `List` or `Form` view. But before doing that, you'll need to configure the links you want to include.

### Minimal Setup

For a basic setup, which includes legal links (like privacy policy and terms of use), app rating, and a contact email, you can configure LinksKit like this:

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

> **Tip:** The `providerToken` is part of your app's campaign link (look for the `pt` query parameter). Campaign links are a great way to track where users are finding your app. Learn more about them [here](https://developer.apple.com/help/app-store-connect/view-app-analytics/manage-campaigns). LinksKit automatically uses your app's Bundle ID as the campaign token, so no extra setup is needed.

> **Note:** LinksKit will automatically add Apple's terms of use link to `.legalLinks` for apps with in-app purchases. No need to configure it yourself – it just works! 🚀

### Optional Extras

LinksKit goes beyond the basics, offering more customization to fit your needs. You can:

* Add an FAQ link with `faqURL` passed to `.helpLinks`
* Link to your app's or developer's social media with `.socialMenus(appLinks:developerLinks:)`
* Promote your other apps or apps from friends using `.appMenus(ownAppLinks:friendsAppLinks:)`

Here’s a real-world example from my app [TranslateKit](https://apps.apple.com/app/apple-store/id6476773066?pt=549314&ct=github.com&mt=8), showcasing all of these features:

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

> **Note:** The `.ownApp` and `.friendsApp` helpers behave differently for a reason. LinksKit will automatically append your `providerToken` for your own apps, while you'll need to manually include a `publisherToken` for your friends’ apps if you know it.

### View Setup

To add LinksKit to your app’s settings screen, typically structured as a `Form` or `List`, just insert a `LinksView()` like so:

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

And that’s it! If you’re not targeting macOS, the result should look like this:

<img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/PhoneSettings.jpeg" />

For macOS apps, the best place for these links is often in the Help menu. You can easily add a `LinksView()` to the menu bar:

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

Here’s what that will look like on macOS:

<img src="https://raw.githubusercontent.com/FlineDev/LinksKit/main/Images/MacHelpMenu.jpeg" />

### Custom Links & Menus 

If the default helpers like `.helpLinks` or `.appMenus` don't fit your exact use case, you can create fully custom `LinkSection` instances and add your own links. You can even nest them! For example, `.appMenus` is just a convenience for this equivalent `LinkSection`:


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

The `entries` parameter accepts one of `.menu(LinkMenu)` or `.link(Link)` and you can nest as many levels as SwiftUI supports (`.menu` is rendered as a `Menu` view, `.link` as a `Button`).

### Localization

All of LinksKit's built-in strings are already localized in around 40 languages, covering all the languages supported by iOS. No setup is needed. If you require additional languages, feel free to open an issue on GitHub – I’m happy to add them!

If you need to localize the names of your apps or any other passed text, you can use `String(localized:)` as usual in your app.


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
