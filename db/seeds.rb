require 'csv'
# Reads and saves language codes from language-codes.csv file.
csv_data = File.read('language-codes.csv')
parsed_csv = CSV.parse(csv_data, headers: true).to_a

parsed_csv.drop(1).each do |record|
  LanguageCode.create(code: record[0], country: record[1])
end