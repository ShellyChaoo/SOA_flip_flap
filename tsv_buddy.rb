# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    rows = tsv.split("\n").map { |line| line.split("\t") }
    headers = rows.first
    data = rows[1..-1]
    key_values = data.map do |row|
      row.map.with_index { |cell, i| [headers[i], cell] }.to_h
    end
    @data = key_values
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    keys = @data[0].keys
    values = @data.map { |x| x.values.reduce { |y1, y2| "#{y1}\t#{y2}" } }
    keys.join("\t") + "\n" + values.join("\n") + "\n"
  end
end
