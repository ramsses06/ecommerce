class Myemail < ActiveRecord::Base

	validates_presence_of :email, message: "Correo requerido."
	validates_uniqueness_of :email, message: "Este correo ya se encuentra registrado."
	# validar correo electronico con devise
	validates_format_of :email, with: Devise::email_regexp, message: "Correo inválido."

end
