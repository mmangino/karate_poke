class User < ActiveRecord::Base

  # START:BELT
  belongs_to :belt
	# END:BELT  
  # START:ASSOCIATIONS
  has_many :attacks, :foreign_key=>:attacking_user_id
  has_many :defenses, :class_name=>"Attack", :foreign_key=>:defending_user_id
  # END:ASSOCIATIONS
  # START:SENSEI
  belongs_to :sensei, :class_name=>"User", :foreign_key=>:sensei_id
  has_many :disciples, :class_name=>"User", :foreign_key=>:sensei_id
	# END:SENSEI
  # START:COMMENTS
  has_many :comments
  has_many :made_comments, :class_name=>"Comment", :foreign_key=>:poster_id
  # END:COMMENTS

  # START:INITIAL_BELT
  before_create :set_initial_belt
	
	def set_initial_belt
	  self.belt = Belt.initial_belt
	end
  # END:INITIAL_BELT

  # START:ATTACK
  def attack(other_user,move)
    returning attacks.create!(:defending_user=>other_user,
                              :move=>move) do |a|
      if a.hit?
        increment :total_hits 
        if belt.should_be_upgraded?(self)
          self.belt=belt.next_belt
          notify_of_new_belt
        end
      end
      save!
    end
  end
	# END:ATTACK
  
# START:BATTLES
def battles(page=1)
  page ||= 1
  Attack.paginate(
    :conditions=>
      ["attacking_user_id=? or defending_user_id=?",
      self.id,self.id],
    :include=>[:attacking_user,:defending_user,:move],
    :order=>"attacks.created_at desc",
    :page => page,
    :per_page => 5)
end
# END:BATTLES

  # START:AVAILABLE_MOVES
  def available_moves
    Move.find(:all,
      :conditions=>["difficulty_level <= ?",belt.level],
      :order=>"name asc")
  end
	# END:AVAILABLE_MOVES
	
	
	# START:STORY
  def notify_of_new_belt
    AttackPublisher.deliver_new_belt_notification(self)
  rescue Facebooker::Session::TooManyUserCalls=>e
    nil
  end
	# END:STORY

  # START:COMMENT_ON
  def comment_on(user,body)
    made_comments.create!(:user=>user,:body=>body)
  end
  # END:COMMENT_ON
  
	# START:DISCIPLES
  def friends_with_senseis(friends_facebook_ids)
	  User.find(:all, 
	    :conditions=>["facebook_id in (?) and sensei_id is not null",
	                  friends_facebook_ids])
  end
	# END:DISCIPLES

  def hometown
    fb_user = Facebooker::User.new(facebook_id)
    location = fb_user.hometown_location
    text_location = "#{location.city} #{location.state}"
    text_location.blank? ? "an undisclosed location" : text_location
  end

	
  # START:USER_FOR
	def self.for(facebook_id,facebook_session=nil)
		returning find_or_create_by_facebook_id(facebook_id) do |user|
			unless facebook_session.nil?
				user.store_session(facebook_session.session_key) 
			end
		end
	end
  # END:USER_FOR
  
  # START:STORE_SESSION
	def store_session(session_key)
	  if self.session_key != session_key
			update_attribute(:session_key,session_key) 
		end
	end
  # END:STORE_SESSION
  
  def hometown(fb_user)
    fb_user ||= Facebooker::User.new(facebook_id)
    location = fb_user.hometown_location
    text_location = "#{location.city} #{location.state}" unless location.blank?
    text_location.blank? ? "an undisclosed location" : text_location
  end
  
  	
  def facebook_session
    @facebook_session ||=  # <label id="code.conditional-assign" />
      returning Facebooker::Session.create do |session| # <label id="code.returning" />
        session.secure_with!(session_key,facebook_id,1.day.from_now) # <label id="code.secure-with" />
        Facebooker::Session.current=session
    end
  end
  
end
