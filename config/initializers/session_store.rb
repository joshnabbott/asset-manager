# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_asset-manager_session',
  :secret      => '5c34ca4cb4248c674a575a46225a6bf5cacad7c69b8dfcfed81b56a7bf5fb2f8ad4c7b66ad53d71ea558315200f42fafb6684dd2cb3aeaee12a825ba08a360c0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
