# defines a new GraphQL type
Types::LinkType = GraphQL::ObjectType.define do
  # this type is named `Link`
  name 'Link'

  # it has the following fields
  field :id, !types.ID
  field :url, !types.String
  field :description, !types.String

  # add postedBy field to Link type
  # - "-> { }": helps against loading issues between types
  # - "property": remaps field to an attribute of Link model
  field :postedBy, -> { Types::UserType }, property: :user
  field :votes, -> { !types[Types::VoteType] }
end