# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

#  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #Changed per ruby forum to get rid of authenticity issue
  protect_from_forgery :only => [:create, :update, :destroy]

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
