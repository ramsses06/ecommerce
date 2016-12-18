# == Schema Information
#
# Table name: myemails
#
#  id         :integer          not null, primary key
#  email      :string
#  ip         :string
#  state      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Myemail < ActiveRecord::Base

	validates_presence_of :email, message: "Correo requerido."
	validates_uniqueness_of :email, message: "Este correo ya se encuentra registrado."
	# validar correo electronico con devise
	validates_format_of :email, with: Devise::email_regexp, message: "Correo inválido."

end
