ActionController::Base.session = {
  :key         => '_asset_manager_session',
  :secret      => '5c34ca4cb4248c674a575a46225a6bf5cacad7c69b8dfcfed81b56a7bf5fb2f8ad4c7b66ad53d71ea558315200f42fafb6684dd2cb3aeaee12a825ba08a360c0'
}

ActionController::Dispatcher.middleware.insert_before(
  ActionController::Session::CookieStore, FlashSessionCookieMiddleware, ActionController::Base.session_options[:key]
)