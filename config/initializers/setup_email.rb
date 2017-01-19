ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "gmail",
  user_name: "user@gmail",#con variables de entorno
  password: "password",#con variables de entorno
  authentication: :plain, #:plain, #:login,
  enable_starttls_auto: true
}
