class FreemlController < ApplicationController
  def index
    @entries = current_user.year.freeml_entries.order('freeml_id DESC')
  end
end
