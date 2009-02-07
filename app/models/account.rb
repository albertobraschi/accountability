require 'csv'
class Account < ActiveRecord::Base
  has_many :outgoings
  has_many :incomings
  has_many :statements
  validates_presence_of :account_type

  attr_accessor :csv_file_name
  cattr_accessor :csv_file_name
  attr_accessor :csv_file
  cattr_accessor :csv_file

  def current_balance at_date=Date.today
    opening_balance - (outgoings.sum_to_date(at_date) || 0.0) + (incomings.sum_to_date(at_date) || 0.0)
  end

  def import_csv
    puts "File is #{@csv_file_name}"
    @csv_file = CSV::Reader.parse(File.open(@csv_file_name,'rb') )
    puts "load as #{@csv_file}"
    #based around NAB export
    @csv_file.each do |row|
      
      transaction = Transaction.new     
      transaction.amount = row[1]
      d= row[0].split("-")
      d[1] = Date::ABBR_MONTHNAMES.index(d[1]) 
      transaction.transaction_date = Date.new(2000+d[2].to_i, d[1], d[0].to_i)
      transaction.detail = row[4] 
      transaction.type = ( transaction.amount > 0 ) ?  'Incoming' : 'Outgoing'
      transaction.account_id = self.id
      transaction.save! 
    end
  end
  def self.import_july
    puts "File is #{@@csv_file_name}"
    @@csv_file = CSV::Reader.parse(File.open(@@csv_file_name,'rb') )
    self.csv_file.each do |row|
      puts row.inspect
      account_id = row[3].match(/VISA/) ? 2 : 1
      transaction = Transaction.new     
      transaction.amount = row[1]
      d= row[0].split("/")
      puts d.inspect
      transaction.transaction_date = Date.new(d[0].to_i, d[1].to_i, d[2].to_i)
      transaction.detail = row[2] 
      transaction.type = ( transaction.amount > 0 ) ?  'Incoming' : 'Outgoing'
      transaction.account_id = account_id 
      transaction.save! 
    end
  end
end
