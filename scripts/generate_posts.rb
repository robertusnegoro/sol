#!/usr/bin/env ruby
# Generates 50 sample Jekyll posts in _posts/
require "date"

POSTS_DIR = File.join(__dir__, "..", "_posts")

TITLES = [
  "Getting started with static sites",
  "Why readability matters in design",
  "A short guide to typography on the web",
  "Building a blog with Jekyll",
  "Thoughts on minimalism in software",
  "Learning to write in public",
  "The case for slow technology",
  "How I organize my reading list",
  "Notes on remote work",
  "Simple habits for better focus",
  "Exploring markdown and plain text",
  "Why I switched to a static site",
  "Lessons from a year of blogging",
  "Designing for accessibility first",
  "The joy of side projects",
  "Reflections on digital minimalism",
  "Setting up a development environment",
  "Quick tips for better sleep",
  "On learning new programming languages",
  "The importance of sidebars and margins",
  "Writing documentation that helps",
  "My favorite open-source tools",
  "Thoughts on note-taking systems",
  "Keeping a personal knowledge base",
  "Why I prefer dark mode",
  "A few words on open source",
  "Building habits that stick",
  "The power of incremental change",
  "On reading and retention",
  "Simple ways to reduce distractions",
  "What I learned from writing daily",
  "The value of constraints in design",
  "Reflections on creative work",
  "How to structure a long article",
  "Thoughts on RSS and the open web",
  "Making time for deep work",
  "On choosing the right tools",
  "Why I keep a journal",
  "The art of the small commit",
  "Learning in public: one year in",
  "Design principles I follow",
  "On building in public",
  "Simple automation that saves time",
  "Why typography is interface",
  "Reflections on shipping",
  "A brief history of my setup",
  "On curiosity and learning",
  "The case for plain text",
  "How I approach new projects",
  "Closing thoughts on simplicity",
]

UNSPLASH_IMAGES = [
  "https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=1200&q=80",
  "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=1200&q=80",
  "https://images.unsplash.com/photo-1455390582262-044cdead277a?w=1200&q=80",
  "https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?w=1200&q=80",
  "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=1200&q=80",
  "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=1200&q=80",
  "https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=1200&q=80",
  "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=1200&q=80",
  "https://images.unsplash.com/photo-1504639725590-34d0984388bd?w=1200&q=80",
  "https://images.unsplash.com/photo-1557804506-669a67965ba0?w=1200&q=80",
]

def slug(title)
  title.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
end

def sample_paragraph
  [
    "This is a sample post to populate the blog. Replace this content with your own writing.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    "You can edit or delete these posts. Each post supports a featured image, author, and optional Disqus comments.",
    "The theme is built for readability: comfortable line length, clear typography, and a minimal layout.",
    "Add your own voice and ideas. The structure is here; the rest is up to you.",
  ].sample
end

# Generate 50 posts from 2024-06-01 to 2025-02-02 (roughly one every 5 days)
start_date = Date.new(2024, 6, 1)
used_titles = []

50.times do |i|
  date = start_date + (i * 5)
  title = (TITLES - used_titles).sample
  used_titles << title
  title = TITLES[i % TITLES.size] if title.nil?  # fallback if we run out
  used_titles.uniq!

  filename = "#{date.strftime("%Y-%m-%d")}-#{slug(title)}.md"
  filepath = File.join(POSTS_DIR, filename)
  image = UNSPLASH_IMAGES[i % UNSPLASH_IMAGES.size]

  content = <<~MD
    ---
    layout: post
    title: "#{title.gsub('"', '\\"')}"
    date: #{date.strftime("%Y-%m-%d")} 12:00:00 +0000
    author: default
    image: #{image}
    image_alt: "#{title.gsub('"', '\\"')}"
    ---

    #{sample_paragraph}

    ## Section

    Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.

    - Point one
    - Point two
    - Point three

    Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
  MD

  File.write(filepath, content)
  puts "Created #{filename}"
end

puts "Done. 50 posts created in _posts/"
