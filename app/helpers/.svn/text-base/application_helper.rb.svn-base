# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # START:NAME
  def name(user,options={})
    fb_name(user,
      {:ifcantsee=>(user.nickname||"a hidden ninja")}.merge(options))
  end
  
  def external_name(user)
    user.nickname || "a hidden ninja"
  end
    
  # END:NAME
  
  def attack_result(attack)
    attack.hit? ? "hit" : "missed"
  end

end
