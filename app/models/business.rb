class Business < ActiveRecord::Base

  def self.nearest_businesses(lat, lng, radius = 1, offset = 0, size = 10)
    sql = %{
      SELECT *, AsText(location), 
        SQRT(POW( ABS( X(location) - X(POINT(#{lat}, #{lng}))), 2) + POW( ABS(Y(location) - Y(POINT(#{lng}, #{lng}))), 2 )) AS distance 
      FROM businesses 
      WHERE Intersects( location, 
        GeomFromText(
          CONCAT('POLYGON((', 
          X(POINT(#{lat}, #{lng})) - #{radius}, ' ', Y(POINT(#{lat}, #{lng})) - #{radius}, ',', 
          X(POINT(#{lat}, #{lng})) + #{radius}, ' ', Y(POINT(#{lat}, #{lng})) - #{radius}, ',', 
          X(POINT(#{lat}, #{lng})) + #{radius}, ' ', Y(POINT(#{lat}, #{lng})) + #{radius}, ',', 
          X(POINT(#{lat}, #{lng})) - #{radius}, ' ', Y(POINT(#{lat}, #{lng})) + #{radius}, ',', 
          X(POINT(#{lat}, #{lng})) - #{radius}, ' ', Y(POINT(#{lat}, #{lng})) - #{radius}, '))' 
        )
      ) 
      ) 
      AND SQRT(POW( ABS( X(location) - X(POINT(#{lat}, #{lng}))), 2) + POW( ABS(Y(location) - Y(POINT(#{lat}, #{lng}))), 2 )) < #{radius} 
      ORDER BY distance
      LIMIT #{offset}, #{size};
    }

    Business.find_by_sql(sql)
  end

end
