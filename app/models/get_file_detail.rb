class GetFileDetail

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :fi_id, :fi_name


  validates :fi_name, presence: true

  def initialize()
    @fi_id    = :fi_id
    @fi_name  = :fi_name
  end



  def persisted?
    false
  end

end
