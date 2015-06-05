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
    puts "Installing Jekyll #{jekyll_version}"
    pipe "/app/bin/gem install jekyll -v #{jekyll_version}", out: "2>&1", user_env: true
    @bundler_cache.store
  end

  def default_config_vars
    super.merge({
      "RAILS_SERVE_STATIC_FILES"  => env("RAILS_SERVE_STATIC_FILES") || "enabled"
    })
  end
end
