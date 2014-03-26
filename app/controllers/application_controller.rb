class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :get_footer_content

  def get_footer_content
    @footer_content = content_for "footer_content"
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # override CanCan's default of checking current_user
  def current_ability
    @current_ability ||= Ability.new(current_member)
  end

  private

    def mercury_update_footer
      @footer_content = content_for "footer_content"
      authorize! :edit, @footer_content
      @footer_content.content = params[:content][:footer_content][:value]
      @footer_content.save
    end

    def content_for(content_name)
      content = EditableContent.find_by_name content_name

      if content.nil?
        content = EditableContent.new
        content.name = content_name
        content.save
      end

      return content
    end
end
