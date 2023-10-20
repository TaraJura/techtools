import os
import sys
import requests
import ccxt

def place_buy_order(api_key, api_secret):
    try:
        print(f"Python Executable: {sys.executable}")
        # Initialize Binance API
        binance = ccxt.binance({
            'apiKey': api_key,
            'secret': api_secret,
        })
        binance.load_time_difference()
        binance.options['defaultType'] = 'future'

        # Fetch ticker directly from Binance API
        response = requests.get('https://fapi.binance.com/fapi/v1/ticker/bookTicker?symbol=BTCUSDT')
        ticker_data = response.json()
        price = ticker_data.get('askPrice')

        if price is not None:
            price = float(price)
            print(f"Ask Price: {price}")

            # Fixed position size in USDT
            fixed_position_size_usdt = 100

            # Calculate position size based on fixed value
            max_position = fixed_position_size_usdt / price
            max_position = round(max_position, 3)

            # Place market buy order
            try:
                binance.create_market_buy_order('BTC/USDT', max_position, {'recvWindow': 60000})
                print(f"Market buy order of {max_position} BTC placed successfully.")
            except Exception as e:
                print(f"Error: {e}")
        else:
            print("Price is None.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    api_key = input("Enter your API key: ")
    api_secret = input("Enter your API secret: ")
    place_buy_order(api_key, api_secret)
