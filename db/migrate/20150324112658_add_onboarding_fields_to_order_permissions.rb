class AddOnboardingFieldsToOrderPermissions < ActiveRecord::Migration
  def change
    add_column :order_permissions, :onboarding_id, :string, limit: 36, null: true
    add_column :order_permissions, :permissions_granted, :boolean, null: true
  end
end
