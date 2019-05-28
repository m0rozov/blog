class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true
      t.string     :title
      t.text       :text
      t.inet       :ip, index: true
      t.integer    :rate_count, index: true, default: 0
      t.integer    :rate_sum, index: true, default: 0
    end
  end
end
