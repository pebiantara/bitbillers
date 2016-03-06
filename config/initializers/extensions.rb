class Float
  def scale_2
    ('%.2f' % self).to_f
  end
end

class String
  def numeric?
    Float(self) != nil rescue false
  end
end