require "rack/livereload"

use Rack::LiveReload

###
# Compass
###

# Susy grids in Compass
# First: gem install susy --pre
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

helpers do
  def img_tag(opts={})

    opts = {
      :width => nil,
      :height => nil,
      :label => nil,
      :thumbnail => nil,
      :class => ""
    }.merge!(opts)

    if opts[:size]
      opts[:width], opts[:height] = opts[:size].split("x")
    end

    if opts[:width]
      figure_style = "width:#{opts[:width]}px"
    else
      figure_style = nil
    end

    content_tag :figure, :style=>figure_style, :class => opts[:class] do

      if opts[:thumbnail]
        content_tag :a, :href => opts[:image], :rel => "facybox" do
          tag :img, :src => opts[:thumbnail], :width => opts[:width], :height => opts[:height], :alt => opts[:label], :title => opts[:label]
        end
      else
        content_tag :img, :src => opts[:image], :alt => opts[:label], :title => opts[:label], :width => opts[:width], :height => opts[:height] do
        end
      end

      if opts[:label]
        content_tag :figcaption do
          opts[:label]
        end
      end

    end

  end

  def stipendiat_year_tag(year)
    content_tag :h4 do
      content_tag :span do
        year
      end
      content_tag(:a, :name => year) {}
    end
  end
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

activate :sprockets

set :js_dir, "js"
set :css_dir, 'css'

set :js_assets_paths, ["#{root}/components/", "#{root}/source/js/"]

set :images_dir, 'img'

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true,
               :autolink => true,
               :smartypants => true


# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript


  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
