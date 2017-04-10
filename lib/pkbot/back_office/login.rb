module Pkbot::BackOffice
  module Login
    def login
      id2 = "https://id2.action-media.ru"
      puts "Logging in..."
      # link = "http://bo.profkiosk.ru/api/auth/login"
      # first_attempt = get link, 'first_attempt'
      # auth_page     = get first_attempt['location'], "auth_page"

      link = "#{id2}/logon/index?appid=74&reglink=&p=1&r=0.4971437090779589"
      # link = "http://bo.profkiosk.ru/api/auth/login"
      auth_page     = get link, "auth_page"

      html = parse_html auth_page

      login_fields  = extract_fields html
      login_fields['Login'] = LOGIN
      login_fields['Pass']  = PASSWORD
      login_fields['ConfirmationCode'] = ''

      auth_path = form_action html
      # auth_uri  = URI(first_attempt['location'])

      # url = "#{auth_uri.scheme}://#{auth_uri.host}#{auth_path}"
      check_login_path = "#{id2}/Logon/CheckLogin"
      check_login_page = post(check_login_path, {
          params: {user: LOGIN, passwrod: PASSWORD, referrer: ''},
          request_headers: {
            'DNT' => '1',
            'X-Requested-With' => 'XMLHttpRequest',
            'Content-Type' => 'application/json; charset=utf-8',
            'X-NewRelic-App-Data' => 'PxQPU1RSDQYTVVBaBQgBUVUTGhE1AwE2QgNWEVlbQFtcCxYsZyIcLgtRWA8lDFZHQgsNDlJDGCUMVFVYLgkEC15AFFIWCBgCHVUKVARSAVdIBhtDIiIPdgVRWFtycAFeIQAOd0BKBQNcEV0/',
            'X-xss-protection' => '1; mode=block',
            'Strict-Transport-Security' => 'max-age=7776000',
            'X-Content-Type-Options' => 'nosniff',
          }
        }, 'check_login')

      url = "https://id2.action-media.ru#{auth_path}"
      puts "Logon POST path: #{url}"

      action_login = post(url, {
        params: login_fields,
        request_headers: {
          'Upgrade-Insecure-Requests' => '1',
          'Referer' => link
        }
      }, 'auth_post')
      # pk_login     = get action_login['location'], 'pk_auth'
    end

    def logout
      cookie_jar.clear
    end

    AUTH_COOKIE = '.ASPXAUTH'
    def logged_in?
      cookie = cookie_jar.find {|cookie| cookie.name == AUTH_COOKIE}
      cookie && cookie.expires > Time.now
    end

    def relogin
      logout
      login
    end
  end
end