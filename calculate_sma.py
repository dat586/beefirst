def calculate_sma(prices, period):
    sma_list = list()  # Instantiate an empty list of results

    if period > len(prices) or period <= 0:
        return sma_list  # If period is greater than number of prices or is less than or equal to 0,
        # immediately return the empty result list

    for price in prices:
        index = prices.index(price) + 1  # Get list index, add one to represent day number
        if index < period:
            sma_list.append(None)  # If day number is less than period requested, add None type to list
        else:
            total = 0  # Instantiate total value at 0
            for i in prices[index - period:index]:  # Loop over prices list, starting at 'period' days ago,
                # going through to current day iteration
                total += i  # Add each day to total value
            average = round(total / period, 2)  # Compute average and round to 2 decimal places
            sma_list.append(average)

    return sma_list


closing_prices = [120.25, 121.30, 119.45, 122.50, 123.75, 124.80, 123.90]
days = 3

smas = calculate_sma(closing_prices, days)
print(smas)
