{pkgs, ...}: let
  cascadeTheme = pkgs.fetchFromGitHub {
    owner = "cascadefox";
    repo = "cascade";
    rev = "main";
    sha256 = "sha256-gyq5WHheiUNkyfxLVkHu8BzTRLzxniH6gQmgrPTv9e4=";
  };
in {
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        # Cascade theme support
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;

        # Session management: Always start fresh, no tab restore
        "browser.sessionstore.resume_from_crash" = false;
        "browser.startup.page" = 0;
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.newtab.url" = "about:blank";

        # Privacy: Strict settings, no data collection
        "browser.contentblocking.category" = "strict";
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "network.cookie.cookieBehavior" = 1; # Block third-party cookies
        "dom.security.https_only_mode" = true;
        "privacy.donottrackheader.enabled" = true;

        # Disable all autofill and save features
        "signon.rememberSignons" = false; # No password saving
        "signon.autofillForms" = false; # No general autofill prompts
        "browser.formfill.enable" = false; # No form autofill
        "extensions.formautofill.addresses.enabled" = false; # Disable save/fill addresses
        "extensions.formautofill.creditCards.enabled" = false; # Disable save/fill payment methods

        # Disable telemetry and data collection
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "browser.discovery.enabled" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;

        # Remove bloat
        "identity.fxaccounts.enabled" = false; # No Firefox Account
        "extensions.pocket.enabled" = false; # No Pocket
        "browser.safebrowsing.phishing.enabled" = false; # No Safe Browsing
        "browser.safebrowsing.malware.enabled" = false;

        # Performance: Speed and low memory usage
        "gfx.webrender.all" = true; # WebRender for speed
        "layers.acceleration.force-enabled" = true; # Hardware acceleration
        "browser.cache.disk.enable" = true; # Disk cache to lower RAM use
        "browser.cache.memory.capacity" = 307200; # 300MB memory cache
        "content.notify.interval" = 100000; # Faster repaints
        "network.http.pipelining" = true; # Faster HTTP requests
        "network.http.max-connections" = 1200; # More connections
        "nglayout.initialpaint.delay" = 0; # Instant page rendering
        "dom.ipc.processCount" = 1; # Single process for efficiency
        "browser.tabs.animate" = false; # No tab animations
        "general.smoothScroll" = false; # No smooth scrolling

        # Disable unnecessary features
        "browser.topsites.contile.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.search.suggest.enabled" = false; # No search suggestions
        "browser.urlbar.suggest.searches" = false; # No URL bar suggestions
        "browser.urlbar.showSearchSuggestionsFirst" = false;
      };

      # Search engine: DuckDuckGo only
      search = {
        force = true;
        default = "DuckDuckGo";
        engines = {
          "DuckDuckGo" = {
            urls = [{template = "https://duckduckgo.com/?q={searchTerms}";}];
            iconUpdateUrl = "https://duckduckgo.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000; # 24-hour updates
            definedAliases = ["ddg"];
          };
          "NixOS Packages" = {
            urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];
            iconUpdateUrl = "https://nixos.org/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000; # 24-hour updates
            definedAliases = [":n"];
          };
          "Bing".metaData.hidden = true;
          "Amazon".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Wikipedia".metaData.hidden = true;
        };
      };
    };
  };

  # Apply Cascade theme
  home.file.".mozilla/firefox/default/chrome" = {
    source = "${cascadeTheme}/chrome";
    recursive = true;
  };
}
