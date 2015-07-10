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

  def test_finding_by_ISO_3166_1_Alpha_3_code
    details = CountryCodesTable.with_alpha_3('DZA')
    assert_equal 'Algeria',   details.name
    assert_equal 'DZA',       details.alpha3
  end

  def test_finding_by_ISO_3166_1_Numeric_code
    details = CountryCodesTable.with_numeric('008')
    assert_equal 'Albania',   details.name
    assert_equal '008',       details.numeric
  end

  def test_finding_by_ITU_code
    details = CountryCodesTable.with_itu('AGL')
    assert_equal 'Angola',    details.name
    assert_equal 'AGL',       details.itu
  end


  def test_finding_by_GEC_code
    details = CountryCodesTable.with_gec('AY')
    assert_equal 'Antarctica', details.name
    assert_equal 'AY',         details.gec
  end

  def test_finding_by_IOC_code
    details = CountryCodesTable.with_ioc('GEQ')
    assert_equal 'Equatorial Guinea', details.name
    assert_equal 'GEQ',               details.ioc
  end

  def test_finding_by_FIFA_code
    details = CountryCodesTable.with_fifa('ROS3')
    assert_equal 'Antarctica',  details.name
    assert_equal 'ROS3',        details.fifa
  end

  def test_finding_by_DS_code
    details = CountryCodesTable.with_ds('RA')
    assert_equal 'Argentina', details.name
    assert_equal 'RA',        details.ds
  end

  def test_finding_by_wmo_code
    details = CountryCodesTable.with_wmo('NU')
    assert_equal ["Aruba", "Bonaire, Sint Eustatius and Saba"],   details.map(&:name)
    assert_equal ["NU", "NU"],                                    details.map(&:wmo)
  end

  def test_finding_by_gaul_code
    details = CountryCodesTable.with_gaul('17')
    assert_equal 'Australia', details.name
    assert_equal '17',        details.gaul
  end

  def test_finding_by_marc_code
    details = CountryCodesTable.with_marc('aa')
    assert_equal 'Albania', details.name
    assert_equal 'aa',      details.marc
  end

  def test_finding_by_dial_code
    details = CountryCodesTable.with_dial('1-242')
    assert_equal 'Bahamas', details.name
    assert_equal '1-242',   details.dial
  end

  #TODO : raise NotFoundError when ..
  #TODO : better handling of results being collections
end
