class UserService
  def initialize(action, user_params = nil, email = nil, password = nil)
    @action = action
    @user_params = user_params
    @email = email
    @password = password
    @user = nil
  end

  def call
    case @action
    when :create
      create_user(@user_params)
    when :login
      login(@email, @password)
    when :checkout_history
      get_checkout_history(@user)
    else
      raise ArgumentError, "Invalid action: #{@action}"
    end
  end

  def set_user(user)
    @user = user
  end

  private

  def create_user(user_params)
    user = User.new(user_params)
    if user.save
      { message: 'User created successfully' }
    else
      { errors: user.errors.full_messages }
    end
  end

  def login(email, password)
    user = User.find_for_database_authentication(email: email)
    if user&.valid_password?(password)
      generate_auth_token(user)
      { message: 'Login successful', user: user, auth_token: user.auth_token }
    else
      { error: 'Invalid email or password' }
    end
  end

  def generate_auth_token(user)
    user.update!(auth_token: Devise.friendly_token)
  end

  def get_checkout_history(user)
    return { error: 'User not found' } unless user

    checkouts = Checkout.where(user_id: user.id)
    checkouts
  end
end
