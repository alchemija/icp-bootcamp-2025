import json
from datetime import datetime

"""
Problem Statement:
Imagine you want to track your personal finances. You need a system that allows you to:
    Add Transactions:
        Each transaction should include:
        type: "income" or "expense"
        amount: Numeric value
        category: e.g., "Food", "Rent", "Salary"
        date: YYYY-MM-DD format
    View Transactions:
        Retrieve all stored transactions.
    Generate Financial Summary:
        Calculate and display:
            Total income
            Total expenses
            Balance (income - expenses)
    Handle Missing Data Gracefully:
        Implement error handling if required fields are missing.
    Save Transactions Permanently:
        Store and retrieve transaction data using JSON files.
"""
data_file = 'transactions.json'

def load_transactions():
    try:
        with open(data_file, 'r') as file:
            return json.load(file)
    except FileNotFoundError:
        return []
    except json.JSONDecodeError:
        print('error reading transactions file')
        return []

def save_transactions(transactions):
    try:
        with open(data_file, 'w') as file:
            json.dump(transactions, file)
    except Exception as e:
        print(f'error saving transactions: {e}')

def add_transaction():
    try:
        t_type = input('type (income/expense): ').strip().lower()
        if t_type not in ['income', 'expense']:
            raise ValueError('type must be income or expense')
        amount = float(input('amount: ').strip())
        category = input('category (e.g. "food", "rent", "salary"): ').strip()
        if not category:
            raise ValueError('category cannot be empty')
        date = input('date (yyyy-mm-dd): ').strip()
        try:
            datetime.strptime(date, '%Y-%m-%d')
        except ValueError:
            raise ValueError('date must be in yyyy-mm-dd format')
        t = {'type': t_type, 'amount': amount, 'category': category, 'date': date}
        transactions = load_transactions()
        transactions.append(t)
        save_transactions(transactions)
        print('transaction added')
    except ValueError as e:
        print(f'input error: {e}')
    except Exception as e:
        print(f'unexpected error: {e}')

def view_transactions():
    try:
        transactions = load_transactions()
        if not transactions:
            print('no transactions found')
        for t in transactions:
            print(t)
    except Exception as e:
        print(f'error viewing transactions: {e}')

def generate_summary():
    try:
        transactions = load_transactions()
        income = sum(t['amount'] for t in transactions if t['type'] == 'income')
        expenses = sum(t['amount'] for t in transactions if t['type'] == 'expense')
        print(f'income: {income}, expenses: {expenses}, balance: {income - expenses}')
    except Exception as e:
        print(f'error generating summary: {e}')

def main():
    while True:
        try:
            print('1. add')
            print('2. view')
            print('3. summary')
            print('4. exit')
            choice = input('choice: ').strip()
            match choice:
                case '1': add_transaction()
                case '2': view_transactions()
                case '3': generate_summary()
                case '4': break
                case _: print('invalid choice')
        except Exception as e:
            print(f'unexpected error: {e}')

main()
