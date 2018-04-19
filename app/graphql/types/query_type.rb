Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  # queries are just represented as fields
  #field :allLinks, !types[Types::LinkType] do
  #  # resolve would be called in order to fetch data for that field
  #  resolve -> (obj, args, ctx) { Link.all }
  #end
  field :allLinks, function: Resolvers::LinksSearch  
end
