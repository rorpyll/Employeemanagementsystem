class Attendence < ApplicationRecord
    self.inheritance_column = "not_sti"
    belongs_to :employee

    before_save :working_hour
    before_validation :checkout_time_validation,  on: [:update]

    private

    def working_hour
        unless self.checkout_time.nil?
            data = (self.checkout_time - self.checkin_time).to_i
            hour = (data/3600).to_i
            min = ((data-(hour*3600)) / 60).to_i
            sec = (data-(hour*3600) - (min*60)).to_i
            self.hour = "#{hour} hours #{min} minutes"
        end
    end

    def checkout_time_validation
        return errors.add :base, "Checkout time can't be blank"  unless checkout_time.present? 
       
        return errors.add :base, "Please select date #{checkin_time.strftime("%d-%m-%Y")} and time greater then #{checkin_time.strftime("%H:%M")} :)" unless checkin_time.strftime("%d") == checkout_time.strftime("%d") && checkout_time.strftime("%H:%M") > checkin_time.strftime("%H:%M")
    end

end
