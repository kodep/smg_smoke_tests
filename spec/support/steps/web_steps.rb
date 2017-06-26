module WebSteps
  ELEMENTS = {
    sidebar: {
      leisure_businesses: 'a[href="/app/publishers"] span.icon'
    },
    publishers: {
      index: {
        sort: '[ng-model="sortParams.sorts"]'
      }
    },
    influencers: {
      edit: {
        invite: {
          title: '.modal-title',
          venue_type: 'select[ng-model="venueType"]',
          venue: 'select[ng-model="venue"]'
        }
      },
      index: {
        filters: {
          follower_size: 'select[name="follower_size"]',
          feedback_score: 'input[name="feedback_score"]',
          swayy_score: 'input[name="swayy_score"]',
          likes_score: 'input[name="likes_score"]',
          comments_score: 'input[name="comments_score"]',
          name: 'input[name="name_value"]'
        },
        item: 'section.search-result-item'
      }
    },
    messages: {
      contacts_filter: 'select[name="searchCategories"]',
      search_field: 'input[name="searchValue"]',
      chat_room: '.list-group-item'
    },
    requests: {
      select_size: 'select[name="follower_size"]',
      item: 'table.list-of-requests tr[ng-repeat-start]'
    }
  }

  def within_alias(_alias_start)
    @_alias_start ||= []
    @_alias_start.push(_alias_start)
    yield
    @_alias_start.delete_at(-1)
  end

  def wait_for(exceptions_or_lambda = nil)
    counter = 0
    limit = 10
    if Array(exceptions_or_lambda).all? {|exception| exception.class == Class }
      Array(exceptions_or_lambda).each do |exception|
        begin
          yield
        rescue exception
          counter += 1
          sleep 1
          retry if counter < limit
        end
      end
    elsif (exceptions_or_lambda).class == Proc
      while counter < limit && exceptions_or_lambda.call
        sleep 1
      end
      yield
    end
  end

  def click_element(_alias)
    find(find_selector(_alias)).click
  end

  def show_screen
    screenshot_and_open_image
  end

  def i_should_see(content)
    sleep 1
    expect(page).to have_content(content)
  end

  def i_should_not_see(content)
    sleep 1
    expect(page.has_no_content?(content)).to be true
  end

  def i_should_see_elements(_alias, args={ count: 1 })
    begin
      button = fs(_alias)
    rescue SelectorNotFound
      button = _alias
    end
    sleep 1
    expect(page).to have_selector(button, text: args[:with_text], count: args[:count])
  end

  def field_should_has_value(field_selector, value)
    field = page.all(:css, field_selector).last
    expect(field.value).to eq(value.to_s)
  end

  def reload_page
    execute_script 'location.reload()'
  end

  def select_option_by_text(select_alias, text)
    page.all("select#{find_selector(select_alias)} option", text: text)
    .select { |el| el.text == text }[0].select_option
    sleep 1
  end

  def select_by_label(select_alias, label)
    within fs(select_alias) do
      find("option[label='#{label}']").select_option
    end
  end

  def field_value_should_be(field, expected_value)
    actual_value = nil
    input = page.all(:css, find_selector(field))[0]
    actual_value = input.value
  rescue SelectorNotFound
    wait_for([Capybara::Poltergeist::JavascriptError, Capybara::ElementNotFound]) do
      begin
        input = all("input[id='#{field}']")[0]
      rescue Capybara::Poltergeist::InvalidSelector
        input = nil
      end
      if input
        actual_value = input.value
      else
        label = find_label(field)
        input = all("input[id='#{label[:for]}']")[0]
        actual_value = input.value
      end
    end
  ensure
    expect(actual_value).to eq(expected_value)
  end

  def editable_fg(label_text)
    EditableFG.new(page, self, label_text)
  end

  def press_enter_on(selector)
    find(selector).native.send_keys(:return)
  end

  private
  class SelectorNotFound < StandardError
  end

  class EditableFG
    attr_accessor :page, :example
    def initialize(page, example, label_text)
      @page, @example = page, example
      @label = find_label(label_text)
      @container = @label.find(:xpath, '..')
    end

    def input
      @input_selector ||= "input[name='#{@label[:for]}']"
      (page.all(@input_selector, visible: false) || page.all(@input_selector))[0]
    end

    def should_has_value(expected_value)
      example.expect(value).to example.eq(expected_value)
    end

    def should_be_opened(bool = true)
      example.expect(opened?).to example.eq(bool)
    end

    def edit
      return if opened?
      @edit_icon ||= @container.find('.glyphicon-pencil')
      @edit_icon.click
      sleep 1
    end

    def opened?
      input.visible?
    end

    def save
      @save_icon ||= @container.find('.glyphicon-floppy-disk')
      @save_icon.click
      sleep 1
    end

    def fill(value, opts = { to_save: true })
      edit
      input.set(value)
      if opts[:to_save]
        sleep 1
        save
      end
    end

    def value
      opened? ? input.value : @container.find('span.read-only').text
    end
  end

  def find_label(text)
    page.find('label', text: text)
  end

  def fs(_alias)
    find_selector _alias
  end

  def find_selector(_alias)
    _alias = @_alias_start.join + _alias if @_alias_start.presence && _alias[0] == '.'
    selector = ELEMENTS.dig(*_alias.underscore.split('.').map(&:to_sym))
    raise SelectorNotFound.new(_alias) unless selector
    selector
  end
end
