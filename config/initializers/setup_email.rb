ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "gmail",
  user_name: "ramsses.testmail@gmail.com",#con variables de entorno
  password: "lanalanita123",#con variables de entorno
  authenticate: :login #:plain #:login
  enable_starttls_auto: true
}
