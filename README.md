# SimpleHL7Parser

`simple_hl7_parser` is a gem to parse HL7 text into ruby objects, optimized for developer happiness.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_hl7_parser'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_hl7_parser

## Usage

`SimpleHL7Parser::HL7.parse` parses an HL7 string, returning a `SimpleHL7Parser::HL7Message` object. The returned
object will respond to any message for a segment it contains with an array of matching segments.
Each segment in the array in turn responds to messages based on standard HL7 element definitions.

Example:

```ruby
hl7_string = "MSH|^~\\&|GHH LAB|ELAB-3|GHH OE|BLDG4|200202150930||ORU^R01|CNTRL-3456|P|2.4\nPID|||555-44-4444||EVERYWOMAN^EVE^E^^^^L|JONES|19620320|F|||153 FERNWOOD DR.^^STATESVILLE^OH^35292||(206)3345232|(206)752-121||||AC555444444||67-A4335^OH^20030520\nOBR|1|845439^GHH OE|1045813^GHH LAB|15545^GLUCOSE|||200202150730|||||||||555-55-5555^PRIMARY^PATRICIA P^^^^MD^^|||||||||F||||||444-44-4444^HIPPOCRATES^HOWARD H^^^^MD\nOBX|1|SN|1554-5^GLUCOSE^POST 12H CFST:MCNC:PT:SER/PLAS:QN||^182|mg/dl|70_105|H|||F"

msg = SimpleHL7Parser::HL7.parse(hl7_string)
msg.msh.first.message_type             #=> "ORU^R01"
msg.obr.first.universal_service_id     #=> "15545^GLUCOSE"
msg.obx.first.obr.universal_service_id #=> "15545^GLUCOSE"
msg.obx.first.observation_identifier   #=> "1554-5^GLUCOSE^POST 12H CFST:MCNC:PT:SER/PLAS:QN"
msg.obx.first.observation_value        #=> "^182"
msg.obx.first.units                    #=> "mg/dl"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sufyanadam/simple_hl7_parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

