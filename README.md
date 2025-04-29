Follow these MongoDB Learning steps sequentially as follows:
1. Setup Test Replica set using "Replica Set.pdf"  in windows
2. Work on MongoDB security referring to document "Security.pdf" in the replica set you've created in above step.   
3. Please follow steps listed in "Setup MongoDB shards in windows.pdf"  document to setup four shards in single PC/Laptop
   and use batch file to start all mongod processes of all replica sets in one shot.
4. Use sample json and js files to create addtional collections.
5. Practice CRUD operations using two pdf's 1 and 2
6. Practice Aggregation methods and develop pipelines - refer to document "Aggregation.pdf"
7. Work on creating Indexes and determine its benefits refer to Indexes.pdf and Python Notebook files
8. Python setup in windows
9. Review "Notes on Write Concern.pdf"


import pandas as pd
import sqlparse
from sqlparse.sql import IdentifierList, Identifier, Where, Comparison
from sqlparse.tokens import Keyword, DML
import os

def clean_sql(sql):
    return sql.strip().replace('\n', ' ').replace('\t', ' ')

def is_subselect(parsed):
    if not parsed.is_group:
        return False
    for item in parsed.tokens:
        if item.ttype is DML and item.value.upper() == 'SELECT':
            return True
    return False

def extract_from_part(parsed):
    """Extract full table names only, ignoring aliases."""
    from_seen = False
    tables = []
    for item in parsed.tokens:
        if from_seen:
            if is_subselect(item):
                tables.extend(extract_from_part(item))
            elif item.ttype is Keyword and item.value.upper() in ('WHERE', 'ORDER BY', 'GROUP BY', 'HAVING', 'LIMIT'):
                break
            else:
                if isinstance(item, IdentifierList):
                    for identifier in item.get_identifiers():
                        tables.append(identifier.get_real_name())
                elif isinstance(item, Identifier):
                    tables.append(item.get_real_name())
        elif item.ttype is Keyword and item.value.upper() == 'FROM':
            from_seen = True
    return tables

def extract_select_part(parsed):
    """Extract full column names only, ignoring aliases."""
    select_seen = False
    columns = []
    for item in parsed.tokens:
        if select_seen:
            if item.ttype is Keyword:
                break
            else:
                if isinstance(item, IdentifierList):
                    for identifier in item.get_identifiers():
                        columns.append(identifier.get_real_name())
                elif isinstance(item, Identifier):
                    columns.append(item.get_real_name())
        elif item.ttype is DML and item.value.upper() == 'SELECT':
            select_seen = True
    return columns

def extract_where_part(parsed):
    """Extract columns from WHERE/JOIN ON conditions."""
    criteria_columns = []
    for item in parsed.tokens:
        if isinstance(item, Where):
            for token in item.tokens:
                if isinstance(token, Comparison):
                    criteria_columns.extend(extract_columns_from_comparison(token))
    return criteria_columns

def extract_columns_from_comparison(comp):
    """Get column names from comparison."""
    columns = []
    for token in comp.tokens:
        if isinstance(token, Identifier):
            columns.append(token.get_real_name())
    return columns

def extract_sql_parts(sql_text):
    tables = []
    columns = []
    criteria_columns = []

    statements = sqlparse.parse(sql_text)
    for statement in statements:
        if statement.get_type() != 'SELECT':
            continue
        tables.extend(extract_from_part(statement))
        columns.extend(extract_select_part(statement))
        criteria_columns.extend(extract_where_part(statement))

    return tables, columns, criteria_columns

def process_spreadsheet(file_path):
    print(f"Processing file: {file_path}")
    xls = pd.ExcelFile(file_path)
    df = pd.read_excel(file_path, sheet_name=xls.sheet_names[0])

    sql_column_name = df.columns[0]
    all_rows = []

    for idx, sql in enumerate(df[sql_column_name]):
        if not isinstance(sql, str):
            continue

        tables, columns, criteria_columns = extract_sql_parts(sql)

        # Combine all extracted items into individual rows
        for table in sorted(set(tables)):
            all_rows.append({
                'SQL_Index': idx,
                'Type': 'Table',
                'Name': table
            })

        for column in sorted(set(columns)):
            all_rows.append({
                'SQL_Index': idx,
                'Type': 'Column',
                'Name': column
            })

        for crit_col in sorted(set(criteria_columns)):
            all_rows.append({
                'SQL_Index': idx,
                'Type': 'Criteria_Column',
                'Name': crit_col
            })

    output_df = pd.DataFrame(all_rows)
    output_file = os.path.splitext(os.path.basename(file_path))[0] + '_parsed_output_rows.xlsx'
    output_df.to_excel(output_file, index=False)

    print(f"✅ Completed: Output saved to {output_file}\n")

def process_multiple_spreadsheets(file_list):
    for file_path in file_list:
        process_spreadsheet(file_path)

# Example usage:
if __name__ == "__main__":
    # List of input files
    input_files = [
        'Book1.xlsx',
        'Book2.xlsx',
        'Book3.xlsx'  # Add as many as you want
    ]

    process_multiple_spreadsheets(input_files)
