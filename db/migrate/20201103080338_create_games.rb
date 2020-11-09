class CreateGames < ActiveRecord::Migration[6.0]
  def change
    
    create_table :users do |t|
      t.string :email, null: false
      t.string :key
      t.datetime :auth_at
    end
    
    create_table :matches do |t|
      t.integer :owner_id, null: false
      t.integer :opponent_id
      t.integer :size, default: 10
      t.integer :line, default: 5
      t.integer :result
      t.text :moves, default: ''
    end
    
  end
end
