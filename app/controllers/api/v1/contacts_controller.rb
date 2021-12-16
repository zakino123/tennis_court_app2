class Api::V1::ContactsController < ApiController
  wrap_parameters :contact, include: [:name, :email, :message]

  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      ContactMailer.send_mail(contact).deliver
      render json: contact
    else
      render json: { message: '問い合わせ出来ませんでした'}
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
