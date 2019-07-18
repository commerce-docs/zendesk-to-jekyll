require 'urlizer'

RSpec.describe Urlizer do
  it 'converts image link' do
    expect(
      Urlizer.convert_image_links!(
        'https://support.magento.com/hc/article_attachments/115004341694/segment_condition_total_number_of_orders_less_than_one.png',
        'images'
      )
    ).to eq 'images/segment_condition_total_number_of_orders_less_than_one.png'
  end

  it 'converts topic link' do
    expect(
      Urlizer.convert_topic_links!(
        '[4]: https://support.magento.com/hc/en-us/articles/360005189554',
        {'360005189554'=>'increase-disk-space-for-integration-environment-on-cloud.md',
         '360005189785'=>'space-for-integration-environment-on-cloud.md'}
      )
    ).to eq '[4]: increase-disk-space-for-integration-environment-on-cloud.md'
  end
end
