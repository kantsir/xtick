ActionMailer::Base.smtp_settings = {
    :address              => 'smtp.gmail.com',
    :port                 =>  587,
    :domain               => 'xtick.com',
    :user_name            => 'xtick.com@gmail.com',
    :password             => 'XTickXTick',
    :authentication       => 'plain',
    :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = XTick::Application::XTickDomain::CURRENT_DOMAIN
