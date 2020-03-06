# frozen_string_literal: true

class CreateTestTables < ActiveRecord::Migration[5.2]
  def up
    create_table :a_dummies do |t|
      t.string :attr1
    end

    create_table :b_dummies do |t|
      t.string :attr1
    end

    create_table :c_dummies do |t|
      t.string :attr1
    end

    create_table :model_with_associations do |t|
      t.string :attr1
      t.references :a_dummies, index: true, foreign_key: true
      t.references :b_dummies, index: true, foreign_key: true
    end

    create_join_table :model_with_associations, :c_dummies
  end
end

CreateTestTables.suppress_messages do
  CreateTestTables.migrate(:up)
end
