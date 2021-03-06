class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :recoverable, :encryptable, :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :omniauthable,
        :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nickname, :provider, :url, :username


  def self.find_for_facebook_oauth access_token
    if user = User.where(:url => access_token.info.urls.Facebook).first
      user
    else 
      User.create!( :provider => access_token.provider,
                    :url => access_token.info.urls.Facebook,
                    :username => access_token.extra.raw_info.name,
                    :nickname => access_token.extra.raw_info.username,
                    :email => access_token.extra.raw_info.email,
                    :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else 
      User.create!( :provider => access_token.provider,
                    :url => access_token.info.urls.Vkontakte,
                    :username => access_token.info.name, 
                    :nickname => access_token.extra.raw_info.domain, 
                    :email => access_token.extra.raw_info.domain+'@vk.com', 
                    :password => Devise.friendly_token[0,20]) 
    end
  end

  def self.find_for_twitter_oauth access_token
    if user = User.where(:url => access_token.info.urls.Twitter).first
      user
    else 
      User.create!( :provider => access_token.provider,
                    :url => access_token.info.urls.Twitter,
                    :username => access_token.info.name, 
                    :nickname => access_token.extra.raw_info.screen_name, 
                    :email => access_token.extra.raw_info.screen_name + '@twitter.com', 
                    :password => Devise.friendly_token[0,20]) 
    end
  end
end
