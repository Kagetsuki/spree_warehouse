Spree::Variant.class_eval do
  has_one :visual_code

  def self.find_by_barcode(code)
    Spree::Variant.where(:visual_code_id => Spree::VisualCode.where({:code => code, :type_id => Spree::VisualCodeType.where(:name => "Barcode")}))
  end

  def self.set_barcode(code)
  end
end
