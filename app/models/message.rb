class Message < ActiveRecord::Base
  belongs_to :device
  default_scope { order(created_at: :asc) }

  def text_html
    ApplicationController.helpers.simple_format text
  end

end
