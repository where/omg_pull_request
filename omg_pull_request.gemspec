# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{core}
  s.version = "2.1.5.beta4"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Eplett"]
  s.date = %q{2011-11-07}
  s.description = %q{Core functionality for Where applications}
  s.email = %q{ceplett@where.com}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "README.textile",
    "Rakefile",
    "VERSION",
    "app/controllers/auth/base_controller.rb",
    "app/controllers/auth/facebooks_controller.rb",
    "app/controllers/auth/twitters_controller.rb",
    "app/controllers/core/base_controller.rb",
    "app/controllers/core/locations_controller.rb",
    "app/controllers/core/password_resets_controller.rb",
    "app/controllers/core/users_controller.rb",
    "app/controllers/login/base_controller.rb",
    "app/controllers/login/emails_controller.rb",
    "app/controllers/login/facebooks_controller.rb",
    "app/helpers/core_helper.rb",
    "app/mailers/core/mailer.rb",
    "app/models/core/ad_network.rb",
    "app/models/core/ad_stats.rb",
    "app/models/core/facebook_user.rb",
    "app/models/core/friend.rb",
    "app/models/core/has_facebook_picture.rb",
    "app/models/core/hours.rb",
    "app/models/core/list.rb",
    "app/models/core/location.rb",
    "app/models/core/login.rb",
    "app/models/core/opt_in.rb",
    "app/models/core/password_reset.rb",
    "app/models/core/place.rb",
    "app/models/core/place_view.rb",
    "app/models/core/search.rb",
    "app/models/core/token.rb",
    "app/models/core/user.rb",
    "app/models/offers/deal.rb",
    "app/models/smb/base.rb",
    "app/models/smb/claim.rb",
    "app/models/smb/coupon.rb",
    "app/models/smb/saved_coupon.rb",
    "app/views/auth/twitters/new.html.haml",
    "app/views/core/_geolocation.haml",
    "app/views/core/_merchant_place_header.html.erb",
    "app/views/core/_old_page_footer.html.erb",
    "app/views/core/_old_page_header.html.erb",
    "app/views/core/_page_footer.html.haml",
    "app/views/core/_page_header.html.haml",
    "app/views/core/mailer/password_reset_instructions.haml",
    "app/views/core/password_resets/edit.html.haml",
    "app/views/core/password_resets/new.html.haml",
    "app/views/core/users/_form.html.haml",
    "app/views/core/users/_form.touch.haml",
    "app/views/core/users/edit.html.haml",
    "app/views/core/users/new.html.haml",
    "app/views/core/users/new.touch.haml",
    "app/views/core/users/show.html.haml",
    "app/views/login/_form.html.haml",
    "app/views/login/_form.touch.haml",
    "app/views/login/emails/new.html.haml",
    "app/views/login/emails/new.touch.haml",
    "config/ad_network.yml",
    "config/asset_hosts.yml",
    "config/categories.yml",
    "config/cmapi.yml",
    "config/facebook.yml",
    "config/initializers/active_resource_core_error_fix.rb",
    "config/initializers/active_resource_prefix_options_load_fix.rb",
    "config/initializers/ad_network.rb",
    "config/initializers/asset_hosts.rb",
    "config/initializers/categories.rb",
    "config/initializers/cmapi.rb",
    "config/initializers/date_formats.rb",
    "config/initializers/facebook.rb",
    "config/initializers/geokit.rb",
    "config/initializers/load_helpers.rb",
    "config/initializers/mime_types.rb",
    "config/initializers/normalizes.rb",
    "config/initializers/offers.rb",
    "config/initializers/pantar.rb",
    "config/initializers/places_cache.rb",
    "config/initializers/search.rb",
    "config/initializers/silverpop.rb",
    "config/initializers/smb.rb",
    "config/initializers/twitter.rb",
    "config/initializers/validators.rb",
    "config/initializers/where_web.rb",
    "config/initializers/who.rb",
    "config/offers.yml",
    "config/pantar.yml",
    "config/routes.rb",
    "config/silverpop.yml",
    "config/smb.yml",
    "config/twitter.yml",
    "config/where_web.yml",
    "config/who.yml",
    "core.gemspec",
    "lib/core.rb",
    "lib/core/action_controller_adapter.rb",
    "lib/core/belongs_to_place.rb",
    "lib/core/constants.rb",
    "lib/core/core_ext.rb",
    "lib/core/core_ext/hash.rb",
    "lib/core/core_ext/string.rb",
    "lib/core/dummy_store.rb",
    "lib/core/test_case.rb",
    "lib/engine.rb",
    "lib/normalizes.rb",
    "lib/validators/email_validator.rb",
    "lib/validators/phone_validator.rb",
    "lib/validators/url_validator.rb",
    "lib/validators/zip_validator.rb",
    "lib/where_geocoder.rb",
    "lib/where_ip_geocoder.rb",
    "test/fixtures/jin_ip_geocode",
    "test/fixtures/vcr/ad_network/submit-failure-24.yml",
    "test/fixtures/vcr/ad_network/submit-failure-32.yml",
    "test/fixtures/vcr/ad_network/submit-failure.yml",
    "test/fixtures/vcr/ad_network/submit-success.yml",
    "test/fixtures/vcr/category_menus.yml",
    "test/fixtures/vcr/core/category_menu.yml",
    "test/functional/application_controller_test.rb",
    "test/functional/auth/base_controller_test.rb",
    "test/functional/auth/facebooks_controller_test.rb",
    "test/functional/auth/twitters_controller_test.rb",
    "test/functional/core/locations_controller_test.rb",
    "test/functional/core/password_resets_controller_test.rb",
    "test/functional/core/users_controller_test.rb",
    "test/functional/login/emails_controller_test.rb",
    "test/functional/login/facebooks_controller_test.rb",
    "test/offers/deal_test.rb",
    "test/opt_in_test.rb",
    "test/tasks.rake",
    "test/test_helper.rb",
    "test/tester/.gitignore",
    "test/tester/Rakefile",
    "test/tester/app/controllers/application_controller.rb",
    "test/tester/app/helpers/application_helper.rb",
    "test/tester/app/views/layouts/application.html.erb",
    "test/tester/config.ru",
    "test/tester/config/application.rb",
    "test/tester/config/boot.rb",
    "test/tester/config/environment.rb",
    "test/tester/config/environments/development.rb",
    "test/tester/config/environments/production.rb",
    "test/tester/config/environments/test.rb",
    "test/tester/config/initializers/backtrace_silencers.rb",
    "test/tester/config/initializers/inflections.rb",
    "test/tester/config/initializers/secret_token.rb",
    "test/tester/config/memcache.yml",
    "test/tester/config/routes.rb",
    "test/tester/lib/tasks/.gitkeep",
    "test/tester/script/rails",
    "test/tester/vendor/plugins/.gitkeep",
    "test/unit/core/ad_network_test.rb",
    "test/unit/core/ad_stats_test.rb",
    "test/unit/core/facebook_user_test.rb",
    "test/unit/core/friend_test.rb",
    "test/unit/core/hours_test.rb",
    "test/unit/core/list_test.rb",
    "test/unit/core/location_test.rb",
    "test/unit/core/password_reset_test.rb",
    "test/unit/core/place_test.rb",
    "test/unit/core/place_view_test.rb",
    "test/unit/core/search_test.rb",
    "test/unit/core/token_test.rb",
    "test/unit/core/user_test.rb",
    "test/unit/helpers/core_helper_test.rb",
    "test/unit/normalizes_test.rb",
    "test/unit/smb/claim_test.rb",
    "test/unit/smb/coupon_test.rb",
    "test/unit/smb/saved_coupon_test.rb",
    "test/unit/validators_test.rb",
    "test/unit/where_ip_geocoder_test.rb",
    "test/where_geocoder_test.rb",
    "vendor/cache/Saikuro-1.1.0.gem",
    "vendor/cache/abstract-1.0.0.gem",
    "vendor/cache/actionmailer-3.0.10.gem",
    "vendor/cache/actionpack-3.0.10.gem",
    "vendor/cache/activemodel-3.0.10.gem",
    "vendor/cache/activerecord-3.0.10.gem",
    "vendor/cache/activeresource-3.0.10.gem",
    "vendor/cache/activesupport-3.0.10.gem",
    "vendor/cache/addressable-2.2.6.gem",
    "vendor/cache/arel-2.0.10.gem",
    "vendor/cache/awesome_print-0.4.0.gem",
    "vendor/cache/builder-2.1.2.gem",
    "vendor/cache/chronic-0.3.0.gem",
    "vendor/cache/churn-0.0.13.gem",
    "vendor/cache/colored-1.2.gem",
    "vendor/cache/crack-0.1.8.gem",
    "vendor/cache/dalli-1.0.5.gem",
    "vendor/cache/erubis-2.6.6.gem",
    "vendor/cache/fakeweb-1.3.0.gem",
    "vendor/cache/faraday-0.6.1.gem",
    "vendor/cache/flay-1.4.3.gem",
    "vendor/cache/flog-2.5.3.gem",
    "vendor/cache/formtastic-1.2.3.gem",
    "vendor/cache/geokit-1.5.0.gem",
    "vendor/cache/git-1.2.5.gem",
    "vendor/cache/haml-3.1.2.gem",
    "vendor/cache/hirb-0.5.0.gem",
    "vendor/cache/httparty-0.7.7.gem",
    "vendor/cache/i18n-0.5.0.gem",
    "vendor/cache/jeweler-1.6.4.gem",
    "vendor/cache/json-1.6.1.gem",
    "vendor/cache/json_pure-1.6.1.gem",
    "vendor/cache/koala-1.1.0.gem",
    "vendor/cache/mail-2.2.19.gem",
    "vendor/cache/main-4.7.1.gem",
    "vendor/cache/metaclass-0.0.1.gem",
    "vendor/cache/metric_fu-2.1.1.gem",
    "vendor/cache/mime-types-1.16.gem",
    "vendor/cache/mocha-0.10.0.gem",
    "vendor/cache/multi_json-1.0.3.gem",
    "vendor/cache/multipart-post-1.1.3.gem",
    "vendor/cache/oauth-0.4.5.gem",
    "vendor/cache/oauth2-0.4.1.gem",
    "vendor/cache/pantar-client-1.4.0.gem",
    "vendor/cache/polyglot-0.3.2.gem",
    "vendor/cache/pr_geohash-1.0.0.gem",
    "vendor/cache/rack-1.2.4.gem",
    "vendor/cache/rack-mount-0.6.14.gem",
    "vendor/cache/rack-test-0.5.7.gem",
    "vendor/cache/rails-3.0.10.gem",
    "vendor/cache/rails_best_practices-1.0.1.gem",
    "vendor/cache/railties-3.0.10.gem",
    "vendor/cache/rake-0.8.7.gem",
    "vendor/cache/rcov-0.9.10.gem",
    "vendor/cache/rdoc-3.9.4.gem",
    "vendor/cache/reek-1.2.8.gem",
    "vendor/cache/roodi-2.1.0.gem",
    "vendor/cache/ruby-progressbar-0.0.10.gem",
    "vendor/cache/ruby2ruby-1.3.1.gem",
    "vendor/cache/ruby_parser-2.0.6.gem",
    "vendor/cache/sexp_processor-3.0.7.gem",
    "vendor/cache/silverpopper-0.1.2.gem",
    "vendor/cache/syntax-1.0.0.gem",
    "vendor/cache/thor-0.14.6.gem",
    "vendor/cache/timecop-0.3.5.gem",
    "vendor/cache/treetop-1.4.10.gem",
    "vendor/cache/twitter_oauth-0.4.3.gem",
    "vendor/cache/tzinfo-0.3.30.gem",
    "vendor/cache/vcr-1.11.3.gem"
  ]
  s.homepage = %q{http://github.com/where/core}
  s.licenses = ["you-no-lookie"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{Core functionality for Where applications}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["= 3.0.10"])
      s.add_runtime_dependency(%q<rake>, ["= 0.8.7"])
      s.add_runtime_dependency(%q<dalli>, ["= 1.0.5"])
      s.add_runtime_dependency(%q<geokit>, ["= 1.5.0"])
      s.add_runtime_dependency(%q<pr_geohash>, ["= 1.0.0"])
      s.add_runtime_dependency(%q<httparty>, ["= 0.7.7"])
      s.add_runtime_dependency(%q<haml>, ["= 3.1.2"])
      s.add_runtime_dependency(%q<formtastic>, ["= 1.2.3"])
      s.add_runtime_dependency(%q<koala>, ["= 1.1.0"])
      s.add_runtime_dependency(%q<twitter_oauth>, ["= 0.4.3"])
      s.add_runtime_dependency(%q<oauth2>, ["= 0.4.1"])
      s.add_runtime_dependency(%q<pantar-client>, ["= 1.4.0"])
      s.add_runtime_dependency(%q<silverpopper>, ["= 0.1.2"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<metric_fu>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["= 3.0.10"])
      s.add_dependency(%q<rake>, ["= 0.8.7"])
      s.add_dependency(%q<dalli>, ["= 1.0.5"])
      s.add_dependency(%q<geokit>, ["= 1.5.0"])
      s.add_dependency(%q<pr_geohash>, ["= 1.0.0"])
      s.add_dependency(%q<httparty>, ["= 0.7.7"])
      s.add_dependency(%q<haml>, ["= 3.1.2"])
      s.add_dependency(%q<formtastic>, ["= 1.2.3"])
      s.add_dependency(%q<koala>, ["= 1.1.0"])
      s.add_dependency(%q<twitter_oauth>, ["= 0.4.3"])
      s.add_dependency(%q<oauth2>, ["= 0.4.1"])
      s.add_dependency(%q<pantar-client>, ["= 1.4.0"])
      s.add_dependency(%q<silverpopper>, ["= 0.1.2"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<timecop>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<metric_fu>, [">= 0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["= 3.0.10"])
    s.add_dependency(%q<rake>, ["= 0.8.7"])
    s.add_dependency(%q<dalli>, ["= 1.0.5"])
    s.add_dependency(%q<geokit>, ["= 1.5.0"])
    s.add_dependency(%q<pr_geohash>, ["= 1.0.0"])
    s.add_dependency(%q<httparty>, ["= 0.7.7"])
    s.add_dependency(%q<haml>, ["= 3.1.2"])
    s.add_dependency(%q<formtastic>, ["= 1.2.3"])
    s.add_dependency(%q<koala>, ["= 1.1.0"])
    s.add_dependency(%q<twitter_oauth>, ["= 0.4.3"])
    s.add_dependency(%q<oauth2>, ["= 0.4.1"])
    s.add_dependency(%q<pantar-client>, ["= 1.4.0"])
    s.add_dependency(%q<silverpopper>, ["= 0.1.2"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<timecop>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<metric_fu>, [">= 0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
  end
end

