# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( mobile-menu.js )
Rails.application.config.assets.precompile += %w( ajax-loader.gif )
# Rails.application.config.assets.precompile += %w( application-sassed.css )
# Rails.application.config.assets.precompile += %w( slideme.css )
# Rails.application.config.assets.precompile += %w( unslider-dots.css )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
