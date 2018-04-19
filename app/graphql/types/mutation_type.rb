Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createLink, function: Resolvers::CreateLink.new
  field :createUser, function: Resolvers::CreateUser.new
  field :signInUser, function: Resolvers::SignInUser.new
  field :createVote, function: Resolvers::CreateVote.new
end
