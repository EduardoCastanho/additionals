require File.expand_path('../../test_helper', __FILE__)

class AdditionalsFontAwesomeTest < ActiveSupport::TestCase
  fixtures :projects, :users, :members, :member_roles, :roles,
           :trackers, :projects_trackers,
           :enabled_modules,
           :issue_statuses, :issue_categories, :workflows,
           :enumerations,
           :issues, :journals, :journal_details,
           :custom_fields, :custom_fields_projects, :custom_fields_trackers, :custom_values,
           :time_entries

  include Redmine::I18n

  def setup
    set_language_if_valid 'en'
  end

  def test_value_info_should_return_infos
    info = AdditionalsFontAwesome.value_info('invalid')
    assert_equal [], info

    info = AdditionalsFontAwesome.value_info('fas-car')
    assert info.key?(:name)
    assert_equal 'fa-car', info[:name]
    assert_equal :fas, info[:type]
    assert_equal 'fas fa-car', info[:classes]
    assert_not info.key?(:unicode)
  end

  def test_value_info_regular_icons
    info = AdditionalsFontAwesome.value_info('far-address_book')
    assert info.key?(:name)
    assert_equal 'normal', info[:font_weight]
    assert_equal 'Font Awesome\ 5 Free', info[:font_family]
  end

  def test_value_info_solid_icons
    info = AdditionalsFontAwesome.value_info('fas-address_book')
    assert info.key?(:name)
    assert_equal 900, info[:font_weight]
    assert_equal 'Font Awesome\ 5 Free', info[:font_family]
  end

  def test_value_info_brands_icons
    info = AdditionalsFontAwesome.value_info('fab-xing')
    assert info.key?(:name)
    assert_equal 'normal', info[:font_weight]
    assert_equal 'Font Awesome\ 5 Brands', info[:font_family]
  end

  def test_brands_icon_with_unicode
    info = AdditionalsFontAwesome.value_info('fab-amazon', with_unicode: true)
    assert info.key?(:unicode)
    assert_equal '&#xf270', info[:unicode]
  end

  def test_regular_icon_with_unicode
    info = AdditionalsFontAwesome.value_info('far-calendar', with_unicode: true)
    assert info.key?(:unicode)
    assert_equal '&#xf133', info[:unicode]
  end

  def test_solid_icon_with_unicode
    info = AdditionalsFontAwesome.value_info('fas-archive', with_unicode: true)
    assert info.key?(:unicode)
    assert_equal '&#xf187', info[:unicode]
  end
end