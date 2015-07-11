require "country_codes_table/version"
require 'csv'

module CountryCodesTable
  SELECTOR_A2   = 1
  SELECTOR_A3   = 2
  SELECTOR_NUM  = 3
  SELECTOR_ITU  = 4
  SELECTOR_GEC  = 5
  SELECTOR_IOC  = 6
  SELECTOR_FIFA = 7
  SELECTOR_DS   = 8
  SELECTOR_WMO  = 9
  SELECTOR_GAUL = 10
  SELECTOR_MARC = 11
  SELECTOR_DIAL = 12

  class CountryDetails < Struct.new(:name, :alpha2, :alpha3, :numeric, :itu, :gec, :ioc, :fifa, :ds, :wmo, :gaul, :marc, :dial, :independent, :idx)

    def self.all
      a = CountryCodesTable._dire.each_with_index.map{|args, idx|
        CountryDetails.new(*args, idx )
      }
      a
    end

    def to_alpha_2 ; CountryCodesTable._raw_data[SELECTOR_A2  ][self.idx] end
    def to_alpha_3 ; CountryCodesTable._raw_data[SELECTOR_A3  ][self.idx] end
    def to_numeric ; CountryCodesTable._raw_data[SELECTOR_NUM ][self.idx] end
    def to_itu     ; CountryCodesTable._raw_data[SELECTOR_ITU ][self.idx] end
    def to_gec     ; CountryCodesTable._raw_data[SELECTOR_GEC ][self.idx] end
    def to_ioc     ; CountryCodesTable._raw_data[SELECTOR_IOC ][self.idx] end
    def to_fifa    ; CountryCodesTable._raw_data[SELECTOR_FIFA][self.idx] end
    def to_ds      ; CountryCodesTable._raw_data[SELECTOR_DS  ][self.idx] end
    def to_wmo     ; CountryCodesTable._raw_data[SELECTOR_WMO ][self.idx] end
    def to_gaul    ; CountryCodesTable._raw_data[SELECTOR_GAUL][self.idx] end
    def to_marc    ; CountryCodesTable._raw_data[SELECTOR_MARC][self.idx] end
    def to_dial    ; CountryCodesTable._raw_data[SELECTOR_DIAL][self.idx] end
  end

  def self._dire
    @_dire ||= CSV.parse(File.open(File.expand_path('country_codes_table/data.csv', __dir__)))
  end

  def self._raw_data
    @_raw_data ||= _dire.transpose
  end


  def self._countries_details(keys)
    if keys.is_a?(Array)
      keys.map{|key| CountryDetails.all[key]}
    else
      CountryDetails.all[keys]
    end
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

  def self.with_alpha_2(code)
    @_alpha2_to_idx ||= raw_data_to_index(SELECTOR_A2)
    _countries_details(@_alpha2_to_idx[code])
  end

  def self.with_alpha_3(code)
    @_alpha3_to_idx ||= raw_data_to_index(SELECTOR_A3)
    _countries_details(@_alpha3_to_idx[code])
  end

  def self.with_numeric(code)
    @_numeric_to_idx ||= raw_data_to_index(SELECTOR_NUM)
    _countries_details(@_numeric_to_idx[code])
  end

  def self.with_itu(code)
    @_numeric_to_itu ||= raw_data_to_index(SELECTOR_ITU)
    _countries_details(@_numeric_to_itu[code])
  end

  def self.with_gec(code)
    @_numeric_to_gec ||= raw_data_to_index(SELECTOR_GEC)
    _countries_details(@_numeric_to_gec[code])
  end

  def self.with_ioc(code)
    @_numeric_to_ioc ||= raw_data_to_index(SELECTOR_IOC)
    key = @_numeric_to_ioc[code]
    _countries_details(key)
  end

  def self.with_fifa(code)
    @_numeric_to_fifa ||= raw_data_to_index(SELECTOR_FIFA)
    _countries_details(@_numeric_to_fifa[code])
  end

  def self.with_ds(code)
    @_numeric_to_ds ||= raw_data_to_index(SELECTOR_DS)
    _countries_details(@_numeric_to_ds[code])
  end

  def self.with_wmo(code)
    @_numeric_to_wmo ||= raw_data_to_index(SELECTOR_WMO)
    _countries_details(@_numeric_to_wmo[code])
  end

  def self.with_gaul(code)
    @_numeric_to_gaul ||= raw_data_to_index(SELECTOR_GAUL)
    _countries_details(@_numeric_to_gaul[code])
  end

  def self.with_marc(code)
    @_numeric_to_marc||= raw_data_to_index(SELECTOR_MARC)
    _countries_details(@_numeric_to_marc[code])
  end

  def self.with_dial(code)
    @_numeric_to_dial ||= raw_data_to_index(SELECTOR_DIAL)
    _countries_details(@_numeric_to_dial[code])
  end
end
