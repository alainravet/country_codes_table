require "country_codes_table/version"
require 'csv'

module CountryCodesTable
  class CountryDetails < Struct.new(:name, :alpha2, :alpha3, :numeric, :itu, :gec, :ioc, :fifa, :ds, :wmo, :gaul, :marc, :dial, :independent)

    def self.all
      CountryCodesTable._dire.map{|args| CountryDetails.new(*args) }
    end
  end

  def self._dire
    @_dire ||= CSV.parse(File.open(File.expand_path('country_codes_table/data.csv', __dir__)))
  end

  def self._raw_data
    @_raw_data ||= _dire.transpose
  end

  def self.with_alpha_2(code)
    @_alpha2_to_idx ||= raw_data_to_index(1)
    _countries_details(@_alpha2_to_idx[code])
  end

  def self.raw_data_to_index(selector)
    res = {}
    _raw_data[selector].each_with_index { |obj , idx |
      next unless obj
      if res[obj].nil?
        res[obj] = idx
      elsif res[obj].is_a?(Array)
        res[obj] << idx
      else
        res[obj] = [res[obj]]
        res[obj] << idx
      end

    }
    res
  end

  def self.with_alpha_3(code)
    @_alpha3_to_idx ||= raw_data_to_index(2)
    _countries_details(@_alpha3_to_idx[code])
  end

  def self.with_numeric(code)
    @_numeric_to_idx ||= raw_data_to_index(3)
    _countries_details(@_numeric_to_idx[code])
  end

  def self.with_itu(code)
    @_numeric_to_itu ||= raw_data_to_index(4)
    _countries_details(@_numeric_to_itu[code])
  end

  def self.with_gec(code)
    @_numeric_to_gec ||= raw_data_to_index(5)
    _countries_details(@_numeric_to_gec[code])
  end

  def self.with_ioc(code)
    @_numeric_to_ioc ||= raw_data_to_index(6)
    key = @_numeric_to_ioc[code]
    _countries_details(key)
  end

  def self._countries_details(keys)
    if keys.is_a?(Array)
      keys.map{|key| CountryDetails.all[key]}
    else
      CountryDetails.all[keys]
    end
  end

  def self.with_fifa(code)
    @_numeric_to_fifa ||= raw_data_to_index(7)
    _countries_details(@_numeric_to_fifa[code])
  end

  def self.with_ds(code)
    @_numeric_to_ds ||= raw_data_to_index(8)
    _countries_details(@_numeric_to_ds[code])
  end

  def self.with_wmo(code)
    @_numeric_to_wmo ||= raw_data_to_index(9)
    _countries_details(@_numeric_to_wmo[code])
  end

  def self.with_gaul(code)
    @_numeric_to_gaul ||= raw_data_to_index(10)
    _countries_details(@_numeric_to_gaul[code])
  end

  def self.with_marc(code)
    @_numeric_to_marc||= raw_data_to_index(11)
    _countries_details(@_numeric_to_marc[code])
  end

  def self.with_dial(code)
    @_numeric_to_dial ||= raw_data_to_index(12)
    _countries_details(@_numeric_to_dial[code])
  end

end
