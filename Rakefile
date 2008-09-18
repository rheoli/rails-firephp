require 'rubygems'
Gem::manage_gems
require 'rake/gempackagetask'

#-Specs

PKG_NAME="rails-firephp"
PKG_VERSION="0.0.1"

spec = Gem::Specification.new do |s|
    s.name       = PKG_NAME
    s.version    = PKG_VERSION
    s.author     = "Stephan Toggweiler"
    s.email      = "railspki at rheoli.net"
    s.homepage   = "http://rubyforge.org/projects/rails-firephp"
    s.platform   = Gem::Platform::RUBY
    s.summary    = "Rails plugin to send messages to FirePHP (plugin of FireBug)"
    s.files      = FileList["{bin,docs,lib,test}/**/*"].exclude("rdoc").to_a
    s.require_path      = "lib"
    #s.autorequire       = "openwferu"
    #s.test_file         = "test/runtest.rb"
    s.has_rdoc          = true
    s.extra_rdoc_files  = ['README','ChangeLog','MIT-LICENSE']
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
  pkg.need_zip = true
end

#-Tasks

task :default => [:package]

desc "Publish the beta gem"
task :pgem => [:package] do
  Rake::SshFilePublisher.new("wrath.rubyonrails.org", "public_html/gems/gems", "pkg", "#{PKG_FILE_NAME}.gem").upload
  `ssh wrath.rubyonrails.org './gemupdate.sh'`
end

desc "Publish the API documentation"
task :pdoc => [:rdoc] do
  Rake::SshDirPublisher.new("wrath.rubyonrails.org", "public_html/ar", "doc").upload
end

desc "Publish the release files to RubyForge."
task :release => [ :package ] do
  require 'rubyforge'
  require 'rake/contrib/rubyforgepublisher'

  packages = %w( gem tgz zip ).collect{ |ext| "pkg/#{PKG_NAME}-#{PKG_VERSION}.#{ext}" }

  rubyforge = RubyForge.new
  rubyforge.login
  rubyforge.add_release(PKG_NAME, PKG_NAME, "REL #{PKG_VERSION}", *packages)
end

#=EOF
