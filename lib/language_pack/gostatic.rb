require "language_pack"
require "language_pack/rails42"

class LanguagePack::Gostatic < LanguagePack::Rails42
  # detects if this is a Rails 4.2 app
  # @return [Boolean] true if it's a Rails 4.2 app
  def self.use?
    instrument "rails42.use" do
      rails_version = bundler.gem_version('railties')
      return false unless rails_version
      is_rails42 = rails_version >= Gem::Version.new('4.2.0') &&
                   rails_version <  Gem::Version.new('5.0.0')
      return is_rails42
    end
  end

  def compile
    instrument "gostatic.compile" do
      run!("/app/bin/gem install jekyll -v 2.5.3")
      super
    end
  end

  def default_config_vars
    super.merge({
      "RAILS_SERVE_STATIC_FILES"  => env("RAILS_SERVE_STATIC_FILES") || "enabled"
    })
  end
end
