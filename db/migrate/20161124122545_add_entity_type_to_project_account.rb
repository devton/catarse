class AddEntityTypeToProjectAccount < ActiveRecord::Migration
  def up
    execute %Q{
    CREATE TYPE enum_entity_type AS ENUM ('pf', 'pj', 'mei');
    }

    add_column :project_accounts, :entity_type, :enum_entity_type, index: true
    add_column :project_accounts, :birth_date, :date
  end

  def down
    remove_column :project_accounts, :entity_type
    remove_column :project_accounts, :birth_date

    execute %Q{
    DROP TYPE enum_entity_type_type;
    }
  end
end
