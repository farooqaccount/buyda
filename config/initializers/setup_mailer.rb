ActionMailer::Base.smtp_settings = { 
:address => "smtp.gmail.com", 
:port => 587, 
:domain => "gmail.com", 
:user_name => "buyda.sales@gmail.com", 
:password => "syedfarooq", 
:authentication => "plain", 
:enable_starttls_auto => true,
:openssl_verify_mode => 'none'}