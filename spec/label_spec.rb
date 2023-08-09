require_relative '../lib/item'
require_relative '../lib/label'
require 'rspec'
require 'json'

RSpec.describe Label do
  let(:label_data) { { id: 1, title: 'Test Label', color: 'red' } }
  let(:label) { Label.new(id: label_data[:id], title: label_data[:title], color: label_data[:color]) }
  let(:item) { Item.new(published_date: '2023-08-09') }

  describe '#add_item' do
    it 'adds an item to the label' do
      label.add_item(item)
      expect(label.instance_variable_get(:@items)).to include(item)
      expect(item.label).to eq(label)
    end

    it 'does not add non-Item objects' do
      label.add_item('not an item')
      expect(label.instance_variable_get(:@items)).to be_empty
    end
  end

  describe '.list_all_labels' do
    it 'lists all labels' do
      labels = [label]
      expect do
        Label.list_all_labels(labels)
      end.to output(/Label Title: #{label_data[:title]}\nLabel Color: #{label_data[:color]}/).to_stdout
    end
  end

  describe '.save_all_labels' do
    it 'saves labels data to a file' do
      labels = [label]
      allow(File).to receive(:write)
      Label.save_all_labels(labels)
      expect(File).to have_received(:write).with('labels.json',
                                                 JSON.pretty_generate([{ title: label_data[:title],
                                                                         color: label_data[:color] }]))
    end
  end

  describe '.load_all_labels' do
    it 'loads labels from a file' do
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return(JSON.generate([label_data]))
      loaded_labels = Label.load_all_labels
      expect(loaded_labels.size).to eq(1)
      loaded_label = loaded_labels.first
      expect(loaded_label.title).to eq(label_data[:title])
      expect(loaded_label.color).to eq(label_data[:color])
    end

    it 'returns an empty array if the file does not exist' do
      allow(File).to receive(:exist?).and_return(false)
      loaded_labels = Label.load_all_labels
      expect(loaded_labels).to be_empty
    end
  end
end
