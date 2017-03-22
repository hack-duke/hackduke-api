# This file was auto-generated by lib/tasks/web.rake

desc 'Oauth methods.'
command 'oauth' do |g|
  g.desc 'This method allows you to exchange a temporary OAuth code for an API access token.'
  g.long_desc %( This method allows you to exchange a temporary OAuth code for an API access token. This is used as part of the OAuth authentication flow. )
  g.command 'access' do |c|
    c.flag 'client_id', desc: 'Issued when you created your application.'
    c.flag 'client_secret', desc: 'Issued when you created your application.'
    c.flag 'code', desc: 'The code param returned via the OAuth callback.'
    c.flag 'redirect_uri', desc: 'This must match the originally submitted URI (if one was sent).'
    c.action do |_global_options, options, _args|
      puts JSON.dump($client.oauth_access(options))
    end
  end
end
