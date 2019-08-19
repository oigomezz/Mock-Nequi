class Validator

	def positive_number(number)
 		return number>=0 ? true : false
	end

	def valid_email(email)
		return (email.include?("@") and email.include?(".")) ? true : false
	end

	def strong_password(password)
		return (password.length >=6) ? true : false
	end

	def pocket_name_validator(name)
		return (name.length >= 1 and name[0]!= " ")? true : false
	end

	def date(year,month,day)
		t = Time.now
		if year < t.strftime("%Y").to_i
			return false
		elsif year == t.strftime("%Y").to_i and month < t.strftime("%m").to_i
			return false
		elsif year == t.strftime("%Y").to_i and month == t.strftime("%m").to_i and day < t.strftime("%d").to_i
			return false
		else
			max = nil
			if (month >= 1)  and (month <= 12)  then
                case month
                when 1,3,5,7,8,10,12 then max=31
                when 4,6,9,11 then max=30
                when 2 then	max=28
                end
			end
			if (day>=1) && (day<=max)
				return true
			else
				return false
			end

		end

	end

	def goal_name_validator(name)
		return (name.length >= 1 and name[0]!= " ")? true : false
	end
end
