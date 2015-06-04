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
      puts "Installing Jekyll 2.4.0"
      pipe "/app/bin/gem install jekyll -v 2.4.0", out: "2>&1", user_env: true
    end
  end

  def default_config_vars
    super.merge({
      "RAILS_SERVE_STATIC_FILES"  => env("RAILS_SERVE_STATIC_FILES") || "enabled"
    })
  end
end
