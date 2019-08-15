class UsersController < ApplicationController
  before_action :authorized, except: :create

  # get "users"
  def index
    users = User.all
    render json: users
  end

  # get "users/[:id]", to view other user's information, for example, your friend's profile information on wechat
  def show
  # show is used to view other user's information, for example, your friend's profile information on wechat
    user = User.find(params[:id])
    render json: user 
  end 

  # post "/signup", a new user enters its information and post to create a new user in database
  def create
    user = User.create(user_params)
    # If user created successfully, server gives the user a json web token, user keeps this token in the browser, and use it in headers to authenticate itself when request information from server
    # If frontend is handled by rails, rails will setup a session(with user_id) to authenticate user and persist user connection. Now react handles frontend, getting data using json, we use json web token. 
    if user.valid?
      currentCondition = Condition.find_by(condition_name: params["myCondition"])
      ConditionsUser.create(
        condition_id: currentCondition.id, 
        user_id: user.id, 
        myCondition: currentCondition.condition_name)      
      # byebug
      render json: {
        token: encode_token(user), 
        user: user, 
        currentCondition: currentCondition
      }
    else
      render json: {errors: user.errors.full_messages}
    end
  end

  # get "/profile", view current user's own information
  def profile
# # For server to give information from a client get request, server needs to verify token first. 
#     # server takes the token from the get request header  
#     token = request.headers[:Authorization]
#     # server decode the token, the output is an array, first element is payload, second element is headers
#     decode_token = JWT.decode(token, "GloriousPegasus", true, { algorithm: "HS256"})
#     # decoded token has two parts, payload is the first element, headers is the second element, we take information from payload, in this case, the user_id
#     user_id = decode_token[0]["user_id"]
#     # find the user using the user_id, and give back the information using render 
#     user = User.find(user_id)
# # This continuous four steps logic process was broken into four pieces in applicationController, secret, token, decode_token, current_user
    render json: current_user
  end 


  private
  # note:  rails api, don't need to use require.
  def user_params
    params.require(:user).permit(:username, :password, :realname, :email, :mobile, 
    :status, :age, :gender, :city, :user_pict, :description, :tag)
  end

end