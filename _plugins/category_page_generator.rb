module Jekyll
  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'archive'
        dir = 'category'
        site.categories.each_key do |category|
          site.pages << CategoryPage.new(site, site.source, File.join(dir, Utils.slugify(category)), category)
        end
      end
    end
  end

  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'archive.html')
      self.data['title'] = category
      self.data['type'] = 'category'
      self.data['posts'] = site.categories[category]
    end
  end
end
