require 'rubygems'
require 'bundler/gem_tasks'

require File.expand_path('../lib/guard/goliath/version', __FILE__)

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'rainbow/ext/string' unless String.respond_to?(:color)
require 'rubocop/rake_task'
Rubocop::RakeTask.new(:rubocop)

task default: [:rubocop]

