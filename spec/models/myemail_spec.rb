require 'rails_helper'

RSpec.describe Myemail, type: :model do
  it{ should validate_presence_of(:email).with_message("Correo requerido.") }
  it{ should validate_uniqueness_of(:email).with_message("Este correo ya se encuentra registrado.") }

  # Prueba de validacion de correo electronico
  it "should not create with invalid email" do
  	email = Myemail.new(email:"test@correo.com")
  	expect(email.valid?).to be_truthy
  end

end
