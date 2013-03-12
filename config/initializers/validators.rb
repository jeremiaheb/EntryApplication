
ActiveRecord::Base.class_eval do

  def self.validates_adds_to_100( *attr_names )

    configuration = {}
    
    # Retrieves last element in array IF last element is a hash
    configuration.update(attr_names.extract_options!)

    validates_each( attr_names ) do |record, attr_name, value|

      unless value.nil?
               
        if record.send( attr_name ).is_a?(Integer)
          nums_array = configuration[:sum].map {|attr| record.send( attr ) }.compact

          unless nums_array.inject(0,:+) == 100
              if configuration[:message]
                record.errors.add( attr_name, "#{configuration[:message]}") if value
              else
                record.errors.add( attr_name, "does not sum to 100.") if value
              end
          end
        end
      end
    end
  end

end
