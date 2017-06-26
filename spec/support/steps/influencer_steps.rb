module InfluencerSteps
  def expect_influencers_with_value(field_alias, value, count)
    click_on 'Clear search'
    find(fs(field_alias)).set(value)
    click_on 'Search'
    i_should_see_elements 'influencers.index.item', count: count
  end

  def i_should_see_block_buttons(count)
    i_should_see_elements 'button', with_text: 'Block', count: count
  end

  def i_should_see_admit_buttons(count)
    i_should_see_elements 'button', with_text: 'Admit', count: count
  end
end
