class GeneralSettingsController < ApplicationController
  def index
    @generalsettings = GeneralSettings.all
  end
end
