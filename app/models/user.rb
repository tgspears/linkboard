class User < ActiveRecord::Base

	has_secure_password

	#posts created by the user
	has_many :posts

	#votes cast against this user
	has_many :votes, as: :votable

	#votes cast by this user
	has_many :ratings, class_name: 'Vote'

	validates :email,
	 presence: true,
	 uniqueness: {case_sensitive: false}
	#  format: { with: /.+\@.+\.+/, on: :create}

	validates :password,
	 presence: true,
	 :on => :create

	validates :name, length: {maximum: 20}


	def self.authenticate email,password
		User.find_by_email(email).try(:authenticate, password)
	end

end
