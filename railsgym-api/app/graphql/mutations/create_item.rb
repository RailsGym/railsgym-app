module Mutations
  class CreateItem < GraphQL::Schema::RelayClassicMutation
    graphql_name 'CreateItem'

    field :item, Types::ItemType, null: true
    field :errors, [String], null: true

    argument :user_id, ID, required: true
    argument :category_id, ID, required: true
    argument :title, String, required: true
    argument :url, String, required: true

    def resolve(**args)
      category = Category.find(args[:category_id])
      item = category.items.build(
        user_id: args[:user_id],
        title: args[:title],
        url: args[:url],
      )
      item.save
      {
        item: item,
        errors: item.errors.full_messages
      }
    end
  end
end
