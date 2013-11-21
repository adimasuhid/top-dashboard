class Student < ActiveRecord::Base
  validates :first_name, :last_name, :year_level, :school, presence: true

  has_many :time_logs

  YEAR_LEVEL = {
    "Gr 1" => 0,
    "Gr 2" => 1,
    "Gr 3" => 2,
    "Gr 4" => 3,
    "Gr 5" => 4,
    "Gr 6" => 5,
    "1st HS" => 6,
    "2nd HS" => 7,
    "3rd HS" => 8,
    "4th HS" => 9,
    "College" => 10
  }

  def year_level_name
    YEAR_LEVEL.key(year_level)
  end

  def name
    "#{first_name} #{last_name}"
  end

end
