# Jekyll Premium Blog Template

A simple, elegant, professional Jekyll blog template with readability-first typography, featured images, and configurable integrations. Compatible with **GitHub Pages** (Jekyll 3.10, Ruby 3.3.4).

## Features

- **Typography**: Source Serif 4 (body) and DM Sans (headings), modular scale, comfortable line length
- **Featured image**: Set `image` or `featured_image` in post front matter (relative path or full URL, e.g. Unsplash); optional `image_alt`
- **Authors**: Define authors in `_data/authors.yml`; reference in posts with `author: id`
- **Optional integrations** (off by default): Disqus, Google Analytics, ads (AdSense placeholder)
- **Plugins**: jekyll-paginate, jekyll-sitemap, jekyll-feed, jekyll-seo-tag
- **Optional**: jekyll-archives (use with local build or GitHub Actions; see below)

## Setup with rbenv

This project requires Ruby 3.3.4. Follow these steps to set up the project using rbenv:

### Step 1: Install rbenv (if not already installed)

**On macOS:**
```bash
brew install rbenv ruby-build
```

**On Linux (Ubuntu/Debian):**
```bash
# Install dependencies
sudo apt-get update
sudo apt-get install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

# Install rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
```

**On Linux (Fedora/RHEL):**
```bash
# Install dependencies
sudo dnf install -y git curl openssl-devel readline-devel zlib-devel gcc make bison libyaml-devel libffi-devel gdbm-devel

# Install rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
```

After installation, add rbenv to your shell profile:

**For bash:**
```bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc
```

**For zsh:**
```bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
source ~/.zshrc
```

### Step 2: Install Ruby 3.3.4 using rbenv

```bash
# Install Ruby 3.3.4
rbenv install 3.3.4

# Set it as the global version (optional)
rbenv global 3.3.4

# Or set it locally for this project only
rbenv local 3.3.4
```

**Note:** The project includes a `.ruby-version` file, so if you're in the project directory, `rbenv local 3.3.4` will automatically use this version when you `cd` into the directory.

### Step 3: Verify Ruby installation

```bash
# Check Ruby version
ruby -v
# Should output: ruby 3.3.4...

# Check rbenv is working
rbenv version
# Should show: 3.3.4 (set by /path/to/project/.ruby-version)
```

### Step 4: Install Bundler

```bash
gem install bundler
```

### Step 5: Navigate to project directory and install dependencies

```bash
# Navigate to the project directory
cd /path/to/blogdekil

# Install project dependencies
bundle install
```

**Note:** If you encounter permission errors, you may need to configure gem installation path:
```bash
# Configure bundler to install gems in the project directory
bundle config set --local path 'vendor/bundle'
```

### Step 6: Run the Jekyll server

```bash
# Start the development server
bundle exec jekyll serve

# Or with live reload (recommended)
bundle exec jekyll serve --livereload
```

The site will be available at `http://localhost:4000` (or the port shown in the terminal).

### Step 7: Build the site (optional)

To build the static site without running the server:

```bash
bundle exec jekyll build
```

The built site will be in the `_site` directory.

## Quick start

**Note:** If you haven't set up rbenv yet, please follow the [Setup with rbenv](#setup-with-rbenv) section above first.

1. **Install dependencies** (Ruby 3.3.4):

1. **Install dependencies** (Ruby 3.3.4):

   ```bash
   bundle install
   ```

2. **Run locally**:

   ```bash
   bundle exec jekyll serve
   ```

3. **Build**:

   ```bash
   bundle exec jekyll build
   ```

## Configuration

Edit **`_config.yml`**:

| Option | Description |
|--------|-------------|
| `name`, `title`, `description` | Site / blog name, page title, meta description |
| `url`, `baseurl` | Production URL and base path (e.g. `/blog` for project pages) |
| `logo`, `favicon` | Paths to logo and favicon (e.g. `/assets/images/logo.svg`) |
| `permalink` | Post URL pattern (e.g. `/:year/:month/:day/:title/`) |
| `include`, `exclude` | Files/dirs to include or exclude from the site |
| `disqus_shortname` | Disqus shortname (leave blank to disable comments) |
| `google_analytics` | GA4 measurement ID (e.g. `G-XXXXXXXXXX`) |
| `ads` | Set to `true` to show ad block; set `ads_client` and `ads_slot` for AdSense |
| `paginate`, `paginate_path` | Posts per page and path (e.g. `/page:num/`) |

### Authors

Add entries in **`_data/authors.yml`**:

```yaml
jane:
  name: Jane Doe
  display_name: Jane
  gravatar: "https://www.gravatar.com/avatar/abc123"
  twitter: janedoe
  description: "Writer and developer."
```

Reference in posts: `author: jane`.

### Kramdown

Markdown is rendered with **Kramdown** (GFM input, Rouge syntax highlighting). Options are in `_config.yml` under `kramdown:`.

### Automated Category Pages
To support category pages on GitHub Pages (where the `jekyll-archives` plugin is restricted), this project uses a local shell script to generate static category files.

1.  **Create a post** with a category:
    ```yaml
    ---
    title: "My New Post"
    category: Design
    ---
    ```
2.  **Run the generation script** locally:
    ```bash
    ./bin/generate_categories.sh
    ```
3.  **Commit** the generated `category/` files along with your post.

This script scans your `_posts` directory and automatically creates/updates the `category/<name>/index.md` files needed to display category archives.

### Sample Content Generation
To populate your blog with sample posts (useful for testing pagination and layout):

```bash
ruby scripts/generate_posts.rb
```

This will create 50 sample posts in `_posts/` with various dates, categories, and featured images.

## Project structure

```
├── _config.yml       # Site and plugin config
├── Gemfile           # github-pages gem (+ optional jekyll-archives)
├── _layouts/         # default, post, page, home
├── _includes/        # head, header, footer, disqus, google_analytics, ads, author
├── _data/authors.yml # Author records
├── _sass/            # Typography, layout, components
├── assets/css/       # main.scss → main.css
├── assets/images/    # Logo, favicon, post images
├── _posts/           # Blog posts
├── _pages/           # Optional pages (about, etc.) via “pages” collection
├── scripts/          # Helper scripts (content generation, etc.)
├── bin/              # Utility scripts (category generation)
├── index.html        # Home (layout: home, paginated)
└── .github/workflows/jekyll-pages.yml  # Optional: build + deploy with custom plugins
```

## License

Use and modify as you like.
