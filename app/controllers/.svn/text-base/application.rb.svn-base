# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => 'a7cabcdf1499df9ded55d8a3797d9387'
  ensure_authenticated_to_facebook  
  
  # START:HELPER_ATTR
	helper_attr :current_user
  # END:HELPER_ATTR

  attr_accessor :current_user
  before_filter :set_current_user

  # START:CURRENT_USER
  def set_current_user
    set_facebook_session
    # if the session isn't secured, we don't have a good user id
    if facebook_session and 
       facebook_session.secured? and 
       !request_is_facebook_tab?
      self.current_user = User.for(facebook_session.user.to_i,facebook_session) 
    end
  end
  # END:CURRENT_USER

end
