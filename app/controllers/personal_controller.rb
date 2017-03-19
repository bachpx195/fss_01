class PersonalController < ApplicationController
  layout "personal"
  include SidebarPersonal
  before_action :authenticate_user!
end
