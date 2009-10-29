module ImagesHelper
  def gravities
    {
      :center       => Magick::CenterGravity,
      :top          => Magick::NorthGravity,
      :top_right    => Magick::NorthEastGravity,
      :right        => Magick::EastGravity,
      :bottom_right => Magick::SouthEastGravity,
      :bottom       => Magick::SouthGravity,
      :bottom_left  => Magick::SouthWestGravity,
      :left         => Magick::WestGravity,
      :top_left     => Magick::NorthWestGravity
    }
  end
end