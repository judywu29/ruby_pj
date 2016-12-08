
require 'delegate'

class Assistant
    def initialize name
        @name = name
    end

    def read_email
        puts "(#{@name}), It's spam. "
    end
end

class Manager < DelegateClass(Assistant)
    def initialize assistant
        super(assistant)
    end

    def attend_meeting
        puts "please hold my phone"

    end

end

#DelegateClass has a method_missing and Manager inherites this method
ass = Assistant.new "Bill"
mgr = Manager.new ass
mgr.read_email
mgr.attend_meeting 