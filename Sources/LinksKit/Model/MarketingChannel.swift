import Foundation

public enum SocialMedia: String {
   case facebook = "Facebook"
   case github = "GitHub"
   case instagram = "Instagram"
   case linkedin = "LinkedIn"
   case mastodonDotSocial = "Mastodon"
   case pinterest = "Pinterest"
   case reddit = "Reddit"
   case threads = "Threads"
   case tiktok = "TikTok"
   case twitter = "X/Twitter"
   case youtube = "YouTube"

   var systemImage: String {
      switch self {
      case .facebook: "hand.thumbsup"
      case .github: "cat.circle.fill"
      case .instagram: "camera.circle"
      case .linkedin: "point.topleft.down.to.point.bottomright.curvepath"
      case .mastodonDotSocial: "globe"
      case .pinterest: "pin.circle"
      case .reddit: "antenna.radiowaves.left.and.right.circle"
      case .threads: "at.circle.fill"
      case .tiktok: "music.note"
      case .twitter: "bird"
      case .youtube: "play.rectangle.fill"
      }
   }

   func url(username: String) -> URL {
      switch self {
      case .facebook: URL(string: "https://facebook.com/\(username)")!
      case .github: URL(string: "https://github.com/\(username)")!
      case .instagram: URL(string: "https://instagram.com/\(username)")!
      case .linkedin: URL(string: "https://www.linkedin.com/in/\(username)")!
      case .mastodonDotSocial: URL(string: "https://mastodon.social/@\(username)")!
      case .pinterest: URL(string: "https://pinterest.com/\(username)")!
      case .reddit: URL(string: "https://reddit.com/user/\(username)")!
      case .threads: URL(string: "https://www.threads.net/@\(username)")!
      case .tiktok: URL(string: "https://www.tiktok.com/@\(username)")!
      case .twitter: URL(string: "https://twitter.com/\(username)")!
      case .youtube: URL(string: "https://www.youtube.com/\(username)")!
      }
   }
}
