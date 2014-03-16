class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :get_footer_content

  def get_footer_content
    @footer_content = content_for "footer_content"
  end

  private

    def mercury_update_footer
      @footer_content = content_for "footer_content"
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
