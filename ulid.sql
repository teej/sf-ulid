CREATE OR REPLACE FUNCTION base32encode_time(input INT)
RETURNS VARCHAR
IMMUTABLE
AS
$$
WITH setup AS (

SELECT
    -- crockford base32 alphabet
    '0123456789ABCDEFGHJKMNPQRSTVWXYZ' as encoding
  
  , BITAND(BITSHIFTRIGHT(input, (6 - 1) * 8), 256 - 1) as ts_byte_0
  , BITAND(BITSHIFTRIGHT(input, (6 - 2) * 8), 256 - 1) as ts_byte_1
  , BITAND(BITSHIFTRIGHT(input, (6 - 3) * 8), 256 - 1) as ts_byte_2
  , BITAND(BITSHIFTRIGHT(input, (6 - 4) * 8), 256 - 1) as ts_byte_3
  , BITAND(BITSHIFTRIGHT(input, (6 - 5) * 8), 256 - 1) as ts_byte_4
  , BITAND(BITSHIFTRIGHT(input, (6 - 6) * 8), 256 - 1) as ts_byte_5
  
  , BITSHIFTRIGHT(BITAND(ts_byte_0, 224), 5) AS ts_chr_0
  , BITAND(ts_byte_0, 31)                    AS ts_chr_1
  , BITSHIFTRIGHT(BITAND(ts_byte_1, 248), 3) AS ts_chr_2
  , BITOR(
      BITSHIFTLEFT(BITAND(ts_byte_1, 6), 2),
      BITSHIFTRIGHT(BITAND(ts_byte_2, 192), 6)
    )                                        AS ts_chr_3
  , BITSHIFTRIGHT(BITAND(ts_byte_2, 62), 1)  AS ts_chr_4
  , BITOR(
      BITSHIFTLEFT(BITAND(ts_byte_2, 1), 4),
      BITSHIFTRIGHT(BITAND(ts_byte_3, 240), 4)
    )                                        AS ts_chr_5
  , BITOR(
      BITSHIFTLEFT(BITAND(ts_byte_3, 15), 1),
      BITSHIFTRIGHT(BITAND(ts_byte_4, 128), 7)
    )                                        AS ts_chr_6
  , BITSHIFTRIGHT(BITAND(ts_byte_4, 124), 2) AS ts_chr_7
  , BITOR(
      BITSHIFTLEFT(BITAND(ts_byte_4, 3), 3),
      BITSHIFTRIGHT(BITAND(ts_byte_5, 224), 5)
    )                                        AS ts_chr_8
  , BITAND(ts_byte_5, 31)                    AS ts_chr_9
)
SELECT
    SUBSTR(encoding, ts_chr_0 + 1, 1) ||
    SUBSTR(encoding, ts_chr_1 + 1, 1) ||
    SUBSTR(encoding, ts_chr_2 + 1, 1) ||
    SUBSTR(encoding, ts_chr_3 + 1, 1) ||
    SUBSTR(encoding, ts_chr_4 + 1, 1) ||
    SUBSTR(encoding, ts_chr_5 + 1, 1) ||
    SUBSTR(encoding, ts_chr_6 + 1, 1) ||
    SUBSTR(encoding, ts_chr_7 + 1, 1) ||
    SUBSTR(encoding, ts_chr_8 + 1, 1) ||
    SUBSTR(encoding, ts_chr_9 + 1, 1)

FROM setup
$$
;


CREATE OR REPLACE FUNCTION base32encode_randomness(input INT)
RETURNS VARCHAR
IMMUTABLE
AS
$$
WITH setup AS (

  SELECT

      -- crockford base32 alphabet
      '0123456789ABCDEFGHJKMNPQRSTVWXYZ' AS encoding 
    
    , BITAND(BITSHIFTRIGHT(input, (10 -  1) * 8), 256 - 1) AS ts_byte_0
    , BITAND(BITSHIFTRIGHT(input, (10 -  2) * 8), 256 - 1) AS ts_byte_1
    , BITAND(BITSHIFTRIGHT(input, (10 -  3) * 8), 256 - 1) AS ts_byte_2
    , BITAND(BITSHIFTRIGHT(input, (10 -  4) * 8), 256 - 1) AS ts_byte_3
    , BITAND(BITSHIFTRIGHT(input, (10 -  5) * 8), 256 - 1) AS ts_byte_4
    , BITAND(BITSHIFTRIGHT(input, (10 -  6) * 8), 256 - 1) AS ts_byte_5
    , BITAND(BITSHIFTRIGHT(input, (10 -  7) * 8), 256 - 1) AS ts_byte_6
    , BITAND(BITSHIFTRIGHT(input, (10 -  8) * 8), 256 - 1) AS ts_byte_7
    , BITAND(BITSHIFTRIGHT(input, (10 -  9) * 8), 256 - 1) AS ts_byte_8
    , BITAND(BITSHIFTRIGHT(input, (10 - 10) * 8), 256 - 1) AS ts_byte_9
    
    , BITSHIFTRIGHT(BITAND(ts_byte_0, 248), 3)           AS ts_chr_0
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_0, 7), 2),
        BITSHIFTRIGHT(BITAND(ts_byte_1, 192), 6)
      )                                                  AS ts_chr_1
    , BITSHIFTRIGHT(BITAND(ts_byte_1, 62), 1)            AS ts_chr_2
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_1, 1), 4),
        BITSHIFTRIGHT(BITAND(ts_byte_2, 240), 4)
      )                                                  AS ts_chr_3
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_2, 15), 1),
        BITSHIFTRIGHT(BITAND(ts_byte_3, 128), 7)
      )                                                  AS ts_chr_4
    , BITSHIFTRIGHT(BITAND(ts_byte_3, 124), 2)           AS ts_chr_5
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_3, 3), 3),
        BITSHIFTRIGHT(BITAND(ts_byte_4, 224), 5)
      )                                                  AS ts_chr_6
    , BITAND(ts_byte_4, 31)                              AS ts_chr_7
    , BITSHIFTRIGHT(BITAND(ts_byte_5, 248), 3)           AS ts_chr_8
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_5, 6), 2),
        BITSHIFTRIGHT(BITAND(ts_byte_6, 192), 6)
      )                                                  AS ts_chr_9
    , BITSHIFTRIGHT(BITAND(ts_byte_6, 62), 1)            AS ts_chr_10
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_6, 1), 4),
        BITSHIFTRIGHT(BITAND(ts_byte_7, 240), 4)
      )                                                  AS ts_chr_11
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_7, 15), 1),
        BITSHIFTRIGHT(BITAND(ts_byte_8, 128), 7)
      )                                                  AS ts_chr_12
    , BITSHIFTRIGHT(BITAND(ts_byte_8, 124), 2) AS ts_chr_13
    , BITOR(
        BITSHIFTLEFT(BITAND(ts_byte_8, 3), 3),
        BITSHIFTRIGHT(BITAND(ts_byte_9, 224), 5)
      )                                                  AS ts_chr_14
    , BITAND(ts_byte_9, 31)                              AS ts_chr_15
)
SELECT
    SUBSTR(encoding, ts_chr_0  + 1, 1) ||
    SUBSTR(encoding, ts_chr_1  + 1, 1) ||
    SUBSTR(encoding, ts_chr_2  + 1, 1) ||
    SUBSTR(encoding, ts_chr_3  + 1, 1) ||
    SUBSTR(encoding, ts_chr_4  + 1, 1) ||
    SUBSTR(encoding, ts_chr_5  + 1, 1) ||
    SUBSTR(encoding, ts_chr_6  + 1, 1) ||
    SUBSTR(encoding, ts_chr_7  + 1, 1) ||
    SUBSTR(encoding, ts_chr_8  + 1, 1) ||
    SUBSTR(encoding, ts_chr_9  + 1, 1) ||
    SUBSTR(encoding, ts_chr_10 + 1, 1) ||
    SUBSTR(encoding, ts_chr_11 + 1, 1) ||
    SUBSTR(encoding, ts_chr_12 + 1, 1) ||
    SUBSTR(encoding, ts_chr_13 + 1, 1) ||
    SUBSTR(encoding, ts_chr_14 + 1, 1) ||
    SUBSTR(encoding, ts_chr_15 + 1, 1)

FROM setup
$$;

-- Technically only 79 bytes of randomness
CREATE OR REPLACE FUNCTION random_80()
RETURNS INT
AS
$$

SELECT
    BITSHIFTLEFT(BITAND(RANDOM(), 65535), 64) +
    ABS(RANDOM())

$$;

CREATE OR REPLACE FUNCTION ULID()
RETURNS VARCHAR
AS
$$

SELECT
    base32encode_time(DATE_PART(epoch_millisecond, CURRENT_TIMESTAMP())::int) ||
    base32encode_randomness(random_80())


$$;


CREATE OR REPLACE FUNCTION ULID(timestamp INT)
RETURNS VARCHAR
AS
$$

SELECT
    base32encode_time(timestamp) || base32encode_randomness(random_80())

$$;
