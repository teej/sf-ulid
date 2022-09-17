# sf-ulid
An implementation of ULID for the Snowflake data warehouse. Based on the [ULID spec](https://github.com/ulid/spec).

## Usage
```
SELECT ULID();              -- => '01G94HBGZBQ4E3VB2W79VHC47W'
SELECT ULID(1469918176385); -- => '01ARYZ6S41ETT6HK0W51YJ40H5'
