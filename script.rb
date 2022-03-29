require 'csv'

# [ TASK ONE ]
users = []
headers = nil
CSV.foreach("users.csv", headers: true, header_converters: :symbol) do |row|
  headers ||= row.headers
  users << row
end

loans = []
headers = nil
CSV.foreach("loans.csv", headers: true, header_converters: :symbol) do |row|
  headers ||= row.headers
  loans << row
end

app_type = []
headers = nil
CSV.foreach("application_type.csv", headers: true, header_converters: :symbol) do |row|
  headers ||= row.headers
  app_type << row
end


# [ TASK TWO ]
# How many users have more than 1 loan?
multiple_loans = users.select {|user| user[:loan_ids].include?(",")}
puts ""
puts "#{ multiple_loans.length } users have more than one loan \n\n"

# How many users are there with a loan more than $1,000,000?
big_money = loans.select {|loan| loan[:loan_amount].to_i > 1000000}
puts "#{ big_money.length } loans over 1 million \n\n"

# How many loans does each user have? (Display their name, and number of loans)
users.map do |user| 
   users_name = user[:name]
   user_loans = user[:loan_ids]
   puts "#{ users_name } has #{ user_loans.count(",") +1 } loan(s)"
end
puts ""

# How many loans are there of each type? (Display app type, number of loans for that type)
types = app_type.map do |app|
  app.to_h
end

type_one = loans.select {|loan| loan[:application_type_id] === "1" }
puts "#{type_one.length} #{types[0].values_at(:type)[0]} loans"

type_two = loans.select {|loan| loan[:application_type_id] === "2" }
puts "#{type_two.length} #{types[1].values_at(:type)[0]} loans"

type_three = loans.select {|loan| loan[:application_type_id] === "3" }
puts "#{type_three.length} #{types[2].values_at(:type)[0]} loans"

type_four = loans.select {|loan| loan[:application_type_id] === "4" }
puts "#{type_four.length} #{types[3].values_at(:type)[0]} loans"

type_five = loans.select {|loan| loan[:application_type_id] === "5" }
puts "#{type_five.length} #{types[4].values_at(:type)[0]} loans"
puts ""


# [ TASK THREE ]
# 'types' is already a hash established in the last part of task two (see above)
users_h = users.map {|user| user.to_h}
loans_h = loans.map {|loan| loan.to_h}

CSV.open('NEW.csv','w') do |csv|
   csv << [users_h.first.keys[1], types.first.keys[1], loans_h.first.keys[2]]
   users_h.each do |user|
    csv << user.values_at(:name)
   end
   types.each do |type|
    csv << type.values_at(:type)
   end
   loans_h.each do |loan|
    csv << loan.values_at(:loan_amount)
   end
  end
   #while this is all writing into my first column still...
   #I'm pleased to have the correct information pulling from my other files into one, new document
   # CSV FORMATTING GOALS: 

        # username, [type1, type2], [amnt_type1, amnt_type2]
        # username, type3, amnt_type3
        # username, [type2, type1, type5], [amnt_type2, amnt_type1, amnt_type5]

        # and so on...
        # but how to do this?




# [ TASK FOUR ]

# In the '.log' file, we can evaluate the information to see that this log is throwing the user a 'NoMethodError' for a GET request that was triggered. At the top of the log, we see that the GET request was made to an api, expecting to get a JSON formatted data response. We can also see that this request produced a 500, or internal server failure. The log tells us that this call is connected to the 'show' action of the 'LoanApplicationsController'. Then we see that the raised error causes a notification to be sent to bugsnag: 'Notifying https://notify.bugsnag.com of NoMethodError'.
# The log then raises a warning displaying the 'NoMethodError' and informs us that the undefined method is called 'down_payment' and it is undefined because it was being called on a variable whose value is currently nil. Following this, the log lists each instance of this both by the file path and then to the precise line/method where the error is being raised. The log wraps up with a few SQL queries to the database for debugging purposes.
