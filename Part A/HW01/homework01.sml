fun is_older(date1: int * int * int, date2: int * int * int)=
    if (#1 date1) < (#1 date2)
    then true
    else
	if (#1 date1) = (#1 date2) andalso (#2 date1) < (#2 date2)
	then true
	else
	    if (#1 date1) = (#1 date2) andalso (#2 date1) = (#2 date2) andalso (#3 date1) < (#3 date2)
	    then true
	    else false

fun number_in_month(date: (int * int * int) list, month: int) =
    if null date
    then 0
    else if #2 (hd date) = month
    then 1 + number_in_month(tl date, month)
    else number_in_month(tl date, month)		    

fun number_in_months(date:(int * int * int) list, months: int list) =
    if null months
    then 0
    else number_in_month(date, hd months) + number_in_months(date, tl months)	     

fun dates_in_month(dates:(int * int * int) list, month: int) =
    if null dates
    then []
    else if #2 (hd dates) = month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)
		       
fun dates_in_months(dates:(int * int * int) list, months: int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates,tl months)     

fun get_nth(slist: string list, n: int) =
    if n <= 1 
    then hd slist
    else get_nth(tl slist, n - 1)

fun date_to_string(date : int * int * int) =
    let val monthlist = ["January","February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in get_nth(monthlist, #2 date) ^ " "  ^ Int.toString (#3 date) ^", "^ Int.toString (#1 date)
    end

fun number_before_reaching_sum(sum: int, numlist: int list) = 	
    if hd numlist >= sum
    then 0
    else 1 + number_before_reaching_sum(sum - hd numlist, tl numlist)
				       
fun what_month(day: int) = 
    let val daylist = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in 1 + number_before_reaching_sum(day, daylist)			    
    end

fun month_range(day1: int, day2: int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1 + 1, day2)	     

fun oldest(dates: (int * int * int) list) =
    if null dates
    then NONE   
    else let val res = oldest(tl dates)
	     		     
	 in
	     if isSome(res) andalso is_older(valOf res, hd dates)
             then res
	     else SOME(hd dates)	     
	 end	      
	     

fun resonable_date(date: (int * int * int)) =
    if #1 date <= 0
    then false
    else if #2 date < 1 orelse #2 date > 12
    then false
    else let val daylist = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	     fun get_nth_int(slist: int list, n: int) =
		 if n <= 1 
		 then hd slist
		 else get_nth_int(tl slist, n - 1)
	 in if #3 date < 1 orelse #3 date > get_nth_int(daylist, #2 date)
            then false
            else if #3 date = 29 andalso #1 date mod 400 <> 0 andalso(#1 date mod 4 <> 0 orelse #1 date mod 100 = 0)
            then false
	    else true
	 end					       
	     
