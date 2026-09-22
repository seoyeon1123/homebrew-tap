cask "tokenplant" do
  version "0.1.0"
  # 버전을 올릴 때마다 `shasum -a 256 dist/TokenPlant-<버전>.zip` 값으로 갱신한다.
  sha256 "18fd46c8485f7f49ffac2848e3f0b878596b22397a81bd78716ca1981e95e4bd"

  url "https://github.com/seoyeon1123/tokenplant/releases/download/v#{version}/TokenPlant-#{version}.zip"
  name "TokenPlant"
  desc "Menu bar app that grows a plant from AI coding token usage"
  homepage "https://github.com/seoyeon1123/tokenplant"

  depends_on macos: ">= :sonoma"

  app "TokenPlant.app"

  # 이 앱은 Apple 공증을 받지 않았다. Homebrew 로 깔 때는 격리 속성을 떼서
  # 사용자가 Gatekeeper 경고를 보지 않게 한다 — 이게 brew 경로를 주력으로 두는 이유다.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/TokenPlant.app"]
  end

  uninstall quit:       "com.tokenplant.TokenPlant",
            login_item: "TokenPlant"

  zap trash: [
    "~/Library/Application Support/TokenPlant",
    "~/Library/Preferences/com.tokenplant.TokenPlant.plist",
    "~/Library/Saved Application State/com.tokenplant.TokenPlant.savedState",
  ]
end
