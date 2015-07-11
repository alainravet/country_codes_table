# data source : http://www.statoids.com/wab.html

require_relative 'test_helper'

class CountryCodesTableTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::CountryCodesTable::VERSION
  end

  def test_finding_by_ISO_3166_1_Alpha_2_code
    details = CountryCodesTable.with_alpha_2('AF')
    assert_equal 'Afghanistan',   details.name
    assert_equal 'AF',            details.alpha2
  end

  def test_converting_ISO_3166_1_Alpha_2_code
    assert_equal 'AL',   CountryCodesTable.with_alpha_2('AL' ).to_alpha_2
    assert_equal 'DZ',   CountryCodesTable.with_alpha_3('DZA').to_alpha_2
  end


  def test_finding_by_ISO_3166_1_Alpha_3_code
    details = CountryCodesTable.with_alpha_3('DZA')
    assert_equal 'Algeria',   details.name
    assert_equal 'DZA',       details.alpha3
  end

  def test_converting_ISO_3166_1_Alpha_3_code
    assert_equal 'ALB',   CountryCodesTable.with_alpha_2('AL'  ).to_alpha_3
    assert_equal 'DZA',   CountryCodesTable.with_alpha_3('DZA' ).to_alpha_3
  end


  def test_finding_by_ISO_3166_1_Numeric_code
    details = CountryCodesTable.with_numeric('008')
    assert_equal 'Albania',   details.name
    assert_equal '008',       details.numeric
  end

  def test_converting_ISO_3166_1_Numeric_code
    assert_equal '008',   CountryCodesTable.with_alpha_2('AL'  ).to_numeric
    assert_equal '008',   CountryCodesTable.with_numeric('008' ).to_numeric
  end


  def test_finding_by_ITU_code
    details = CountryCodesTable.with_itu('AGL')
    assert_equal 'Angola',    details.name
    assert_equal 'AGL',       details.itu
  end

  def test_converting_ITU_code
    assert_equal 'ALB',   CountryCodesTable.with_alpha_2('AL' ).to_itu
    assert_equal 'AGL',   CountryCodesTable.with_itu('AGL'    ).to_itu
  end


  def test_finding_by_GEC_code
    details = CountryCodesTable.with_gec('AY')
    assert_equal 'Antarctica', details.name
    assert_equal 'AY',         details.gec
  end

  def test_converting_GEC_code
    assert_equal 'AL',   CountryCodesTable.with_alpha_2('AL').to_gec
    assert_equal 'AY',   CountryCodesTable.with_gec('AY'    ).to_gec
  end


  def test_finding_by_IOC_code
    details = CountryCodesTable.with_ioc('GEQ')
    assert_equal 'Equatorial Guinea', details.name
    assert_equal 'GEQ',               details.ioc
  end

  def test_converting_IOC_code
    assert_equal 'ALB',   CountryCodesTable.with_alpha_2('AL').to_ioc
    assert_equal 'GEQ',   CountryCodesTable.with_ioc('GEQ'    ).to_ioc
  end


  def test_finding_by_FIFA_code
    details = CountryCodesTable.with_fifa('ROS3')
    assert_equal 'Antarctica',  details.name
    assert_equal 'ROS3',        details.fifa
  end

  def test_converting_to_FIFA_code
    assert_equal 'ALB',   CountryCodesTable.with_alpha_2('AL' ).to_fifa
    assert_equal 'ROS3',  CountryCodesTable.with_fifa('ROS3'  ).to_fifa
  end


  def test_finding_by_DS_code
    details = CountryCodesTable.with_ds('RA')
    assert_equal 'Argentina', details.name
    assert_equal 'RA',        details.ds
  end

  def test_converting_to_DS_code
    assert_equal 'AL',   CountryCodesTable.with_alpha_2('AL' ).to_ds
    assert_equal 'RA',  CountryCodesTable.with_ds('RA'  ).to_ds
  end


  def test_finding_by_wmo_code
    details = CountryCodesTable.with_wmo('NU')
    assert_equal ["Aruba", "Bonaire, Sint Eustatius and Saba"],   details.map(&:name)
    assert_equal ["NU", "NU"],                                    details.map(&:wmo)
  end

  def test_converting_to_WMO_code
    assert_equal 'AB',   CountryCodesTable.with_alpha_2('AL' ).to_wmo
    assert_equal ['NU','NU'],  CountryCodesTable.with_wmo('NU'  ).map(&:to_wmo)
  end


  def test_finding_by_gaul_code
    details = CountryCodesTable.with_gaul('17')
    assert_equal 'Australia', details.name
    assert_equal '17',        details.gaul
  end

  def test_converting_to_GAUL_code
    assert_equal '3',   CountryCodesTable.with_alpha_2('AL').to_gaul
    assert_equal '17',  CountryCodesTable.with_gaul('17'   ).to_gaul
  end

  def test_finding_by_marc_code
    details = CountryCodesTable.with_marc('aa')
    assert_equal 'Albania', details.name
    assert_equal 'aa',      details.marc
  end

  def test_converting_to_MARC_code
    assert_equal 'aa',   CountryCodesTable.with_alpha_2('AL').to_marc
    assert_equal 'aa',  CountryCodesTable.with_marc('aa'   ).to_marc
  end

  def test_finding_by_dial_code
    details = CountryCodesTable.with_dial('1-242')
    assert_equal 'Bahamas', details.name
    assert_equal '1-242',   details.dial
  end

  def test_converting_to_DIAL_code
    assert_equal '355',   CountryCodesTable.with_alpha_2('AL').to_dial
    assert_equal '1-242', CountryCodesTable.with_dial('1-242').to_dial
  end


  #TODO : raise NotFoundError when ..
  #TODO : better handling of results being collections
end
