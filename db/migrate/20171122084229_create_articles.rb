class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
        t.string :title
        #t.binary :data#, :null => false    
        end
  end
end
