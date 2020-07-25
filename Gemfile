source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 5.2.4', '>= 5.2.4.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'bootsnap', '>= 1.1.0', require: false

# ログイン管理
gem 'devise'
gem 'devise-i18n'

# モデル、ルーティング表記
gem 'annotate'

# アドミン
gem 'rails_admin', '~> 2.0'
# アクセス制限
gem 'cancancan'

# font-awesome
gem 'font-awesome-sass', '~> 5.4.1'

# sendgrid凍結のため本番環境にもletter_opener
gem 'letter_opener_web'

# 画像アップロード
gem 'carrierwave'
gem 'mini_magick'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Faker（ダミーデータ作成）
  gem 'faker'

  gem 'spring'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'factory_bot_rails'
  gem 'launchy'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # gem 'letter_opener_web'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
