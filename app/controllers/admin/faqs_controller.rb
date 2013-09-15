class Admin::FaqsController < Admin::AdminController

  def index
    @faqs = Faq.all
  end

  def edit
    @faq = Faq.find(params[:id])
  end

  def update
    @faq = Faq.find(params[:id])
    if @faq.update(params.require(:faq).permit(:context))
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to admin_faqs_path
  end

end
