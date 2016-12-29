class LinkMailer < ActionMailer::Base

  default from: "links@descargas.down"

  def download_link(link)
    @link = link
    @product = @link.product
    mail(to: link.email, subject:"Descarga de productos adquiridos")
  end

end
