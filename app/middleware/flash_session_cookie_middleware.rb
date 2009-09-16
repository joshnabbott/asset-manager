require 'rack/utils'

class FlashSessionCookieMiddleware
  def initialize(app, session_key = '_session_id')
    @app         = app
    @session_key = session_key
  end

  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      # I don't know what gone awry but env['QUERY_STRING'] is always blank now.
      session_param      = [@session_key, env['rack.request.form_hash'][@session_key]]
      env['HTTP_COOKIE'] = session_param.join('=')
    end

    @app.call(env)
  end
end