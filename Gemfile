source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'middleman'
gem 'middleman-sprockets', '~> 4.0.0.rc'
gem 'middleman-autoprefixer'
gem 'middleman-blog'
gem 'middleman-favicon-maker', '4.0.3'
gem 'middleman-google-analytics', '~> 3.0'
gem 'middleman-imageoptim', github: 'plasticine/middleman-imageoptim', branch: 'master'
gem 'middleman-livereload'
gem 'middleman-pry'
gem 'slim'
gem 'tzinfo-data', platforms: [:mswin, :mingw, :jruby]
gem 'wdm', platforms: [:mswin, :mingw]

source 'https://rails-assets.org' do
    gem 'rails-assets-bootstrap'
end
