class MlArchive < ActiveRecord::Base
  belongs_to :ml_account

  def body_to_html
    self.body.gsub("\n", "<br>").html_safe
  end
end
