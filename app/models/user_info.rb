class UserInfo

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :us_name, :us_adress, :us_phone


  validates :us_name, presence: true

  def initialize(options = {})
    @us_name    = options[:us_name]
    @us_adress = options[:us_adress]
    @us_phone   = options[:us_phone]
  end

  def persisted?
    false
  end

end

