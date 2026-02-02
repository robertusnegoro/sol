# https://pages.github.com/versions/ — keep in sync with GitHub Pages
source "https://rubygems.org"

# Match GitHub Pages environment (Jekyll 3.10.x, Ruby 3.3.x).
# Run: bundle install && bundle exec jekyll serve
gem "github-pages", group: :jekyll_plugins

# Not supported by default on GitHub Pages; use the included
# GitHub Actions workflow to build & deploy so categories work on the live site.
gem "jekyll-archives", group: :jekyll_plugins

gem "wdm", ">= 0.1.0" if Gem.win_platform?
