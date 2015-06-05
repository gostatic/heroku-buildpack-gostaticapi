require "language_pack"
require "language_pack/rails42"

class LanguagePack::Gostatic < LanguagePack::Rails41

  def self.use?
    true
  end

  def name
    "Ruby/Rails (Gostatic)"
  end

  def compile
    instrument "gostatic.compile" do
      super
      install_jekyll
    end
  end

  def install_jekyll
    jekyll_version = "2.4.0"
    jekyll_gem_path = "#{build_path}/vendor/jekyll-gem"
    puts "Installing Jekyll #{jekyll_version}"
    puts "  #{jekyll_gem_path}"
    @cache.load("jekyll_gem", jekyll_gem_path)
    pipe "/app/bin/gem install jekyll -v #{jekyll_version} --install-dir #{jekyll_gem_path}", out: "2>&1", user_env: true
    @cache.store(jekyll_gem_path, "jekyll_gem")
    set_export_override 'GEM_PATH', "/app/vendor/jekyll-gem:#{ENV['GEM_PATH']}"
    set_export_override 'PATH', "/app/vendor/jekyll-gem/bin:#{ENV['PATH']}"
  end

  def default_config_vars
    super.merge({
      "RAILS_SERVE_STATIC_FILES"  => env("RAILS_SERVE_STATIC_FILES") || "enabled"
    })
  end
end
