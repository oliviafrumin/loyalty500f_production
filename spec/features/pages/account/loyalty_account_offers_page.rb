module OffersPage
  include Capybara::DSL

  def add_deal(name)
    click_link 'Add new deal'
    fill_in 'deal_name', with: name
    fill_in 'deal_display_name', with: name + '_Display_Name'
    fill_in 'deal_description', with: name + '_Description'
    find(:xpath, "//div[@id='deal_image_url']//input[@name='file']", wait: 2).set(File.absolute_path('./lib/data/deal.png'))
    sleep 5
    fill_in 'deal_instructions', with: name + '_instructions'
    find(:xpath, "//div[@id='point_rule_timebased_content']/*/dt[contains(text(), 'Start Date')]/input[@class='datepicker hasDatepicker']", wait: 2).click
    find(:xpath, "//div[@id='ui-datepicker-div']/table/tbody/tr/td/a[.//text()='" + Date.today.day.to_s + "']", wait: 2).click
    find(:xpath, "//dt[@id='end_date']/input[@class='datepicker hasDatepicker']", wait: 2).click
    find(:xpath, "//div[@id='ui-datepicker-div']/table/tbody/tr/td/a[.//text()='" + Date.today.day.to_s + "']", wait: 2).click
    status = find(:id, 'deal_status', wait: 2)
    status.click unless status.checked?
    click_link_or_button 'Save'
  end

  def update_deal(name)
    find(:xpath, "//tr[@class='item_table_row_deal']//a//dt[contains(text(), '" + name + "')]", wait: 2).click
    fill_in 'deal_description', with: name + '_Description_Updated'
    click_link_or_button 'Save'
  end

  def delete_deal(name)
    find(:xpath, "//tr[@class='item_table_row_deal']//a//dt[contains(text(), '" + name + "')]", wait: 2).click
    click_link_or_button 'Delete deal'
    find(:xpath, "//div[@class='delete_overlay']//a[@class='primary_button del_button' and contains(text(), 'Delete')]", wait: 2).click
  end

  def add_promotion(name)
    find(:xpath, "//a[contains(text(), 'Manage Promotions')]", wait: 2).click
    find(:xpath, "//div[@id='group-c']/a/div", wait: 2).click
    find(:id, 'point_promotion_external_ids', wait: 2).click
    find(:xpath, "//*[@id='point_promotion_external_ids']", wait: 2).set(name + '_External_ID')
    # binding.pry
    fill_in 'point_promotion_name', with: name
    fill_in 'point_promotion_display_name', with: name + '_Display_Name'
    fill_in 'point_promotion_description', with: name + '_Description'
    fill_in 'point_promotion_legal', with: name + '_Legal'
    find(:xpath, "//div[@id='point_promotion_display_icon_url']//input[@name='file']", wait: 2).set(File.absolute_path('./lib/data/promotion.png'))

    # ==========
    sleep 2
    # binding.pry
    find(:xpath, "//input[@class='datepicker start_date start_date_date hasDatepicker']", wait: 2).click
    sleep 2
    date_start = Date.today.day+ 1
    find(:xpath, "//div[@id='ui-datepicker-div']/table/tbody/tr/td/a[.//text()='" + date_start.to_s + "']", wait: 2).click
    sleep 4
    # time = Time.new.hour+ 2
    page.execute_script "window.scrollTo(0,700)"
    sleep 4
    find(:xpath, "//input[@id='point_promotion_datetime_start_date_time']", wait: 2).click


    availability = verify_content 'Time of day'

    if (availability==true)
      print availability
      sleep 2
      find(:css, 'div.wickedpicker > ul > li:nth-child(1) > span.wickedpicker__controls__control-up', wait: 2).click
      find(:css, 'div.wickedpicker > ul > li:nth-child(3) > span.wickedpicker__controls__control-up', wait: 2).click
      find(:css, 'div.wickedpicker > ul > li:nth-child(4) > span.wickedpicker__controls__control-up', wait: 2).click
    else
      find(:xpath, "//input[@id='point_promotion_datetime_start_date_time']", wait: 2).click
      find(:css, 'div.wickedpicker > ul > li:nth-child(1) > span.wickedpicker__controls__control-up', wait: 2).click
      find(:css, 'div.wickedpicker > ul > li:nth-child(3) > span.wickedpicker__controls__control-up', wait: 2).click
      find(:css, 'div.wickedpicker > ul > li:nth-child(4) > span.wickedpicker__controls__control-up', wait: 2).click
    end
    sleep 2

    # puts time
    find(:xpath, "//input[@class='datepicker end_date end_date_date hasDatepicker']", wait: 2).click
    date_end = Date.today.day+3
    find(:xpath, "//div[@id='ui-datepicker-div']/table/tbody/tr/td/a[.//text()='" + date_end.to_s + "']", wait: 2).click

    # ==========
    find(:id, "point_promotion_point_strategies_attributes_0_rule_type", wait: 2).click
    find(:xpath, "//select[@id='point_promotion_point_strategies_attributes_0_rule_type']/option[@value='equals']", wait: 2).click
    fill_in 'point_promotion_point_strategies_attributes_0_value', with: 5
    status = find(:id, 'point_promotion_active', wait: 2)
    status.click unless status.checked?
    click_link_or_button 'Save'
  end

  def update_promotion(name)
    find(:xpath, "//a[contains(text(), 'Manage Promotions')]", wait: 2).click
    find(:xpath, "//div[@id='group-c']/div/div[contains(@class, 'promotion-name')]/a[.//text()='" + name + "']", wait: 2).click
    fill_in 'point_promotion_point_strategies_attributes_0_value', with: 7
    click_link_or_button 'Save'
  end

  def archive_promotion(name)
    find(:xpath, "//a[contains(text(), 'Manage Promotions')]", wait: 2).click
    find(:xpath, "//div[@id='group-c']/div/div[contains(@class, 'promotion-name')]/a[.//text()='" + name + "']", wait: 2).click
    click_link_or_button 'Archive promotion'
    find(:xpath, "//div[@class='delete_overlay']//a[@class='primary_button del_button' and contains(text(), 'Archive')]", wait: 2).click
  end
end
