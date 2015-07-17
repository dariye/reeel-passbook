class AddAuthTokenToPasses < ActiveRecord::Migration
  def change
    add_column :passes, :authentication_token, :string
  end
end
