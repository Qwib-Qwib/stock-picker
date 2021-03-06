def stock_picker (prices_array) #This method is the intializer. It indicates which buying date we're currently considering.
  i = 0
  total_potential_returns = prices_array.reduce({}) do |initial_day, current_buy_price|
    if i == prices_array.length - 1 #This condition prevents the method from trying to compute buying on the last day, since there would be no day to seel afterwards anyway.
      initial_day
    else
      initial_day["Buy on day #{i}"] = sell_values_calculator(prices_array, buy_date_index = i)  #A method is called to calculate the gains and losses with that specific buying date in mind.
      i += 1
      initial_day
    end
  end
  best_values_for_each_day = total_potential_returns.map {|buying_day, sell_values| sell_values.max{|pair1, pair2| pair1[1] <=> pair2[1]}}  #This creates an array of the best selling values for each buying date, for future comparison. The index of each sub-array corresponds to a buying date, the first element of each sub-array is the corresponding "Sell on day..." string for the best value, the second element is the best value for the specific buying date considered.
  best_selling_value_ever = best_values_for_each_day.max {|array1, array2| array1[1] <=> array2[1]}
  best_dates = [best_values_for_each_day.index(best_selling_value_ever),best_selling_value_ever[0][12, best_selling_value_ever[0].length - 1].to_i]  #We search for the best value ever in the complete array of best values to retrieve the best buying date index. The best selling date index is retrieved by slicing it directly from the "Sell on day..." string.
  p best_dates  #Just for clarity, printing isn't required by the exercise.
end

def sell_values_calculator (prices_array, buy_date_index)
  i = 0 #It's important to work with an iterator because by default reduce doesn't actually remember WHERE It iterates in the collection, which can lead to "funny" results when the same value appears several times.
  prices_array.reduce({}) do |potential_gains_and_losses, current_sell_price|
    if i <= buy_date_index  #This condition excludes all selling values for days before the current buying date.
      i += 1
    else
      potential_gains_and_losses["Sell on day #{i}"] = current_sell_price - prices_array[buy_date_index]
      i += 1
    end
    potential_gains_and_losses
  end
end

stock_picker([17,3,6,9,15,8,6,1,10])