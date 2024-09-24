import Foundation

public enum SocialPlatform: Hashable {
   case facebook
   case github
   case instagram
   case linkedin
   case mastodon(instance: String)
   case pinterest
   case reddit
   case threads
   case tiktok
   case twitter
   case youtube

   var systemImage: String {
      switch self {
      case .facebook: "hand.thumbsup"
      case .github: "cat.circle.fill"
      case .instagram: "camera.circle"
      case .linkedin: "point.topleft.down.to.point.bottomright.curvepath"
      case .mastodon: "square.split.1x2"
      case .pinterest: "pin.circle"
      case .reddit: "antenna.radiowaves.left.and.right.circle"
      case .threads: "at.circle"
      case .tiktok: "music.note"
      case .twitter: "bird"
      case .youtube: "play.rectangle.fill"
      }
   }

   func url(handle: String) -> URL {
      switch self {
      case .facebook: URL(string: "https://facebook.com/\(handle)")!
      case .github: URL(string: "https://github.com/\(handle)")!
      case .instagram: URL(string: "https://instagram.com/\(handle)")!
      case .linkedin: URL(string: "https://www.linkedin.com/in/\(handle)")!
      case .mastodon(let instance): URL(string: "https://\(instance)/@\(handle)")!
      case .pinterest: URL(string: "https://pinterest.com/\(handle)")!
      case .reddit: URL(string: "https://reddit.com/user/\(handle)")!
      case .threads: URL(string: "https://www.threads.net/@\(handle)")!
      case .tiktok: URL(string: "https://www.tiktok.com/@\(handle)")!
      case .twitter: URL(string: "https://twitter.com/\(handle)")!
      case .youtube: URL(string: "https://www.youtube.com/\(handle)")!
      }
   }
}

extension SocialPlatform: CustomStringConvertible {
   public var description: String {
      switch self {
      case .facebook: "Facebook"
      case .github: "GitHub"
      case .instagram: "Instagram"
      case .linkedin: "LinkedIn"
      case .mastodon: "Mastodon"
      case .pinterest: "Pinterest"
      case .reddit: "Reddit"
      case .threads: "Threads"
      case .tiktok: "TikTok"
      case .twitter: "X/Twitter"
      case .youtube: "YouTube"
      }
   }
}
