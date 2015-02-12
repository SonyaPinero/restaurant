class Employee < ActiveRecord::Base 
	attr_reader :password
	
	has_many :orders
	has_many :parties

 	validates :name, presence: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  # have to be able to find a user given an email and password
  def self.find_by_credentials(args = {})
    employee = Employee.find_by(name: args[:name])

    if employee.is_password?(args[:password])
      return employee
    else
      return nil
    end
  end

  # have to figure out how to accept and set a password for the user
  def password=(pwd)
    @password = pwd

    self.password_digest = BCrypt::Password.create(pwd)

    self.save
  end

  # have to figure out how to check if a user submitted password is correct
  def is_password?(pwd)
    bcrypt_pwd = BCrypt::Password.new(self.password_digest)

    return bcrypt_pwd.is_password?(pwd)
  end
end