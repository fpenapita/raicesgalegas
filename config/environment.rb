# Copyright (C) 2010 Felipe Peña Pita
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License Version 3
# as published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "mysql"
  config.gem "matthuhiggins-foreigner", :lib => "foreigner", :source => "http://gemcutter.org"

  config.gem "i18n"
  config.gem "routing-filter", :lib => "routing_filter"

  config.gem "authlogic"

  config.gem "paperclip"

  config.gem "acts-as-taggable-on", :source => "http://gemcutter.org", :version => '2.0.0.rc1'

  # tiny_mce
  config.gem 'jrails'
  config.gem 'responds_to_parent'
  config.gem 'will_paginate', :version => '~> 2.3.11', :source => 'http://gemcutter.org'
  config.gem 'tiny_mce'

  config.gem 'redbox'

  config.gem 'active_link_to'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :comment_observer, :user_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.load_path += Dir[File.join(RAILS_ROOT, 'config', 'locales', '**', '*.{rb,yml}')]
  config.i18n.default_locale = 'gl'
end

ATTACHMENTS_MAX_FILE_SIZE = 500.kilobyte
ATTACHMENTS_PATH = ":rails_root/attachments/:rails_env/:class/:id/:attachment/:style/:basename.:extension"
ATTACHMENTS_URL = "/:class/:id/:attachment/:style/:basename_parameterize"

# URL for tiny_mce attachments. We add the host:port here in order
# to can see correctly the notification mails for a comment
MAILER_AND_TINY_MCE_ATTACHMENTS_PATH = ":rails_root/attachments/:rails_env/:class/:id/:attachment/:style/:basename.:extension"
MAILER_AND_TINY_MCE_ATTACHMENTS_URL = "http://" + HOST + "/:class/:id/:attachment/:style/:basename_parameterize"


ADVANCED_SEARCH_FIELDS = ['name', 'birth_place', 'birth_year', 'destination_place', 'departure_year', 'details']
TEXT_ADVANCED_SEARCH_FIELDS = ['name', 'birth_place', 'destination_place', 'details']
RESULTS_PER_PAGE = 10
EMIGRANTS_TO_HIGHLIGHT = 5


DEFAULT_FROM_MAIL = 'xxxxx'
ActionMailer::Base.delivery_method = :async_smtp
ActionMailer::Base.smtp_settings = {
    :address        => 'xxxxx',
    :port           => 25,
    :authentication => :login,    # Don't change this one.
    :user_name      => "xxxxx",
    :password       => "xxxxx"
}
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.default_url_options = { :host => HOST }
