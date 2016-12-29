ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "gmail",
  user_name: "",#con variables de entorno
  password: "",#con variables de entorno
  authenticate: :login,#plain
  emable_starttls_auto: true
}
