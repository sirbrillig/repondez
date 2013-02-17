class TokensController < ApplicationController
  respond_to :json

  def create
    email = params[:email]
    password = params[:password]

    if email.nil? or password.nil?
      render status: 400, json: {message: "The request must contain email and password"}
      return
    end

    @user = User.find_by_email(email.downcase)
    if @user.nil?
      logger.info("User #{email} failed sign-in: user not found.")
      render status: 401, json: {message: "Invalid email or password"}
      return
    end

    @user.ensure_authentication_token!

    if not @user.valid_password?(password)
      logger.info("User #{email} failed sign-in: password is invalid.")
      render status: 401, json: {message: "Invalid email or password"}
    else
      render status: 200, json: {token: @user.authentication_token}
    end
  end

  # To delete the token, send a DELETE to the URI: http://localhost:3000/tokens/[token]
  def destroy
    @user = User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("Destroy user auth token failed: token not found.")
      render status: 401, json: {message: "Invalid token."}
    else
      @user.reset_authentication_token!
      render status: 200, json: {token: params[:id]}
    end
  end
end
