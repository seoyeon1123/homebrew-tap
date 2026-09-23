cask "tokenplant" do
  version "0.1.1"
  # 버전을 올릴 때마다 `shasum -a 256 dist/TokenPlant-<버전>.zip` 값으로 갱신한다.
  sha256 "455a76816da14d92f467da0e73d8e4caa60f807bf6f1a4ed5429d16b0dd09249"

  url "https://github.com/seoyeon1123/tokenplant/releases/download/v#{version}/TokenPlant-#{version}.zip"
  name "TokenPlant"
  desc "Menu bar app that grows a plant from AI coding token usage"
  homepage "https://github.com/seoyeon1123/tokenplant"

  depends_on macos: :sonoma

  app "TokenPlant.app"

  # 이 앱은 Apple 공증을 받지 않았다. Homebrew 로 깔 때는 격리 속성을 떼서
  # 사용자가 Gatekeeper 경고를 보지 않게 한다 — 이게 brew 경로를 주력으로 두는 이유다.
  #
  # 옛 `postflight do ... end` 블록은 deprecated 다(brew 를 부를 때마다 경고가 뜬다).
  # 선언형 `postflight_steps` 를 쓰고, 경로는 `{{appdir}}` 토큰으로 넘긴다 —
  # `run` 의 `base:` 는 실행 파일에만 걸리고 `args:` 는 리터럴이라 여기서 치환이 필요하다.
  # `-dr` 의 `-r` 는 필수다. 속성이 없을 때 xattr 가 0 이 아닌 값으로 끝나면 설치가 깨진다.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/TokenPlant.app"]
  end

  uninstall quit:       "com.tokenplant.TokenPlant",
            login_item: "TokenPlant"

  zap trash: [
    "~/Library/Application Support/TokenPlant",
    "~/Library/Preferences/com.tokenplant.TokenPlant.plist",
    "~/Library/Saved Application State/com.tokenplant.TokenPlant.savedState",
  ]
end
