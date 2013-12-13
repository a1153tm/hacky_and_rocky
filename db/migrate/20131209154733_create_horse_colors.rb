class CreateHorseColors < ActiveRecord::Migration
  def change
    create_table :horse_colors do |t|
      t.string :text_color
      t.string :background_color

      t.timestamps
    end
    HorseColor.create(text_color: '#333',  background_color: '#FFF')
    HorseColor.create(text_color: 'white', background_color: '#555')
    HorseColor.create(text_color: 'white', background_color: '#FF0000')
    HorseColor.create(text_color: 'white', background_color: '#0044CC')
    HorseColor.create(text_color: 'white', background_color: '#F0C000')
    HorseColor.create(text_color: 'white', background_color: '#009900')
    HorseColor.create(text_color: 'white', background_color: '#FF7700')
    HorseColor.create(text_color: 'white', background_color: '#FF0084')
    HorseColor.create(text_color: 'white', background_color: '#0088CC')
    HorseColor.create(text_color: 'white', background_color: '#33EE33')
  end
end
