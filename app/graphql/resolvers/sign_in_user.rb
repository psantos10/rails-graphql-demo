class Resolvers::SignInUser < GraphQL::Function
  argument :email, !Types::AuthProviderEmailInput

  # defines inline return type for the mutation
  type do
    name 'SigninPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, ctx)
    input = args[:email]

    # basic validation
    return unless input

    user = User.find_by email: input[:email]

    # ensures we have the correct user
    return unless user
    return unless user.authenticate(input[:password])

    # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
    # crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    # store the token in session
    ctx[:session][:token] = token

    OpenStruct.new({
      user: user,
      token: token
    })
  end
end