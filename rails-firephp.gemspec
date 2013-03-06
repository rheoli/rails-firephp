#-Specs

PKG_NAME="rails-firephp"
PKG_VERSION="0.0.2"

Gem::Specification.new do |s|
    s.name       = PKG_NAME
    s.version    = PKG_VERSION
    s.author     = "Stephan Toggweiler"
    s.email      = "railspki at rheoli.net"
    s.homepage   = "https://github.com/rheoli/rails-firephp"
    s.platform   = Gem::Platform::RUBY
    s.summary    = "Rails plugin to send messages to FirePHP (plugin of FireBug)"
    s.files      = `git ls-files`.split($\)
    s.require_paths      = ["lib"]
    #s.has_rdoc          = true
end

#=EOF
