class Material < ApplicationRecord
  belongs_to :recipe

  cattr_accessor :material_unit do
    %w(Kg Lạng Củ Quả Cái Chiếc Muỗng Miếng)
  end
end
