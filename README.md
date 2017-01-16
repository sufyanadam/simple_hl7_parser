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

### Adding support for a HL7 Segment

Just create a class under the `SimpleHL7Parser` module namespace called
`XXXSegment` (where `XXX` is a segment name, such as `PID`), include the
`Segment` module and define a column map. That's it! It's that simple; hence
the name `SimpleHL7Parser`.

The column map is a map of `segment_attribute => position_number`. For example,
the `placer_order_number` is the third element in the `OBR` segment. So the
column map would define `{placer_order_number: 2}`. The `segment_attribute`
part of the column map becomes the name of the function you can call to
retrieve the value of the attribute at the position it maps to.

The example below demonstrates how `SimpleHL7Parser` currently
supports parsing the `OBR` HL7 segment in Ruby:

Example:

```ruby
# Extending SimpleHL7Parser to support another
# HL7 Segment
require 'simple_hl7_parser/segments/segment'

module SimpleHL7Parser
  class OBRSegment
    include Segment

    COLUMN_MAP = {
      set_id:  1,
      placer_order_number:  2,
      filler_order_number:  3,
      universal_service_id:  4,
      priority:  5,
      requested_date_time:  6,
      observation_date_time:  7,
      observation_end_date_time:  8,
    }
  end
end
```

After adding support for a new segment, add a test that demonstrates
it works correctly and make a pull request :)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

