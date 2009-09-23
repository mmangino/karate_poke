ActionController::Routing::Routes.draw do |map|

  # See how all your routes lay out with "rake routes"
  map.resources :invitations
  map.resources :attacks

  # START:COMMENTS
  map.resources :comments
  # END:COMMENTS

  # START:DOJOS
  map.resources :dojos
  # END:DOJOS

  map.resources :users

  # START:HOMEPAGES
  map.battles '',:controller=>"attacks", 
                 :conditions=>{:canvas=>true}
  map.marketing_home '',:controller=>"marketing"
  # END:HOMEPAGES
  
  map.resources :leaders
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
