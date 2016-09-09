package string_operations is
--  -- Type declarations
--  -- ===========================================================================
--  subtype T_RAWCHAR   is std_logic_vector(7 downto 0);
--  type    T_RAWSTRING is array (natural range <>) of T_RAWCHAR;

--  -- testing area:
--  -- ===========================================================================
--  function to_IPStyle(str : string)     return T_IPSTYLE;

--  -- to_char
--  function to_char(Value : std_logic)   return character;
--  function to_char(rawchar : T_RAWCHAR) return character;

--  function to_HexChar(Value : natural)  return character;
--  function to_HexChar(Value : unsigned) return character;

--  -- chr_is* function
--  function chr_isDigit(chr : character)         return boolean;
--  function chr_isLowerHexDigit(chr : character) return boolean;
--  function chr_isUpperHexDigit(chr : character) return boolean;
--  function chr_isHexDigit(chr : character)      return boolean;
--  function chr_isLower(chr : character)         return boolean;
--  function chr_isLowerAlpha(chr : character)    return boolean;
--  function chr_isUpper(chr : character)         return boolean;
--  function chr_isUpperAlpha(chr : character)    return boolean;
--  function chr_isAlpha(chr : character)         return boolean;

--  -- raw_format_* functions
--  function raw_format_bool_bin(Value : boolean)       return string;
--  function raw_format_bool_chr(Value : boolean)       return string;
--  function raw_format_bool_str(Value : boolean)       return string;
--  function raw_format_slv_bin(slv : std_logic_vector) return string;
--  function raw_format_slv_oct(slv : std_logic_vector) return string;
--  function raw_format_slv_dec(slv : std_logic_vector) return string;
--  function raw_format_slv_hex(slv : std_logic_vector) return string;
--  function raw_format_nat_bin(Value : natural)        return string;
--  function raw_format_nat_oct(Value : natural)        return string;
--  function raw_format_nat_dec(Value : natural)        return string;
--  function raw_format_nat_hex(Value : natural)        return string;

--  -- str_format_* functions
--  function str_format(Value : REAL; precision : natural := 3) return string;

--  -- to_string
--  function to_string(Value : boolean) return string;
--  function to_string(Value : integer; base : positive := 10) return string;
--  function to_string(slv : std_logic_vector; format : character; Length : natural := 0; fill : character := '0') return string;
--  function to_string(rawstring : T_RAWSTRING) return string;
--  function to_string(Value : T_BCD_VECTOR) return string;

--  -- to_slv
--  function to_slv(rawstring : T_RAWSTRING) return std_logic_vector;

--  -- digit subtypes incl. error Value (-1)
--  subtype T_DIGIT_BIN  is integer range -1 to 1;
--  subtype T_DIGIT_OCT  is integer range -1 to 7;
--  subtype T_DIGIT_DEC  is integer range -1 to 9;
--  subtype T_DIGIT_HEX  is integer range -1 to 15;

--  -- to_digit*
--  function to_digit_bin(chr : character) return T_DIGIT_BIN;
--  function to_digit_oct(chr : character) return T_DIGIT_OCT;
--  function to_digit_dec(chr : character) return T_DIGIT_DEC;
--  function to_digit_hex(chr : character) return T_DIGIT_HEX;
--  function to_digit(chr : character; base : character := 'd') return integer;

--  -- to_natural*
--  function to_natural_bin(str : string) return integer;
--  function to_natural_oct(str : string) return integer;
--  function to_natural_dec(str : string) return integer;
--  function to_natural_hex(str : string) return integer;
--  function to_natural(str : string; base : character := 'd') return integer;

--  -- to_raw*
--  function to_RawChar(char : character) return T_RAWCHAR;
--  function to_RawString(str : string)    return T_RAWSTRING;

--  -- resize
--  function resize(str : string; size : positive; FillChar : character := C_POC_NUL)      return string;
----  function resize(rawstr : T_RAWSTRING; size : POSITIVE; FillChar : T_RAWCHAR := x"00")  return T_RAWSTRING;

--  -- Character functions
--  function chr_toLower(chr : character) return character;
--  function chr_toUpper(chr : character) return character;

--  -- String functions
--  function str_length(str : string)                   return natural;
--  function str_equal(str1 : string; str2 : string)    return boolean;
--  function str_match(str1 : string; str2 : string)    return boolean;
--  function str_imatch(str1 : string; str2 : string)   return boolean;
--  function str_pos(str : string; chr : character; start : natural := 0)   return integer;
--  function str_pos(str : string; pattern : string; start : natural := 0)  return integer;
--  function str_ipos(str : string; chr : character; start : natural := 0)  return integer;
--  function str_ipos(str : string; pattern : string; start : natural := 0) return integer;
--  function str_find(str : string; chr : character)    return boolean;
--  function str_find(str : string; pattern : string)   return boolean;
--  function str_ifind(str : string; chr : character)   return boolean;
--  function str_ifind(str : string; pattern : string)  return boolean;
  function str_replace(
    str : string;
    pattern : string;
    replace : string;
    max_num_of_replacements : in natural := natural'high
  ) return string;
--  function str_substr(str : string; start : integer := 0; Length : integer := 0) return string;
--  function str_ltrim(str : string; char : character := ' ')  return string;
--  function str_rtrim(str : string; char : character := ' ')  return string;
--  function str_trim(str : string)                            return string;
--  function str_calign(str : string; Length : natural; FillChar : character := ' ') return string;
--  function str_lalign(str : string; Length : natural; FillChar : character := ' ') return string;
--  function str_ralign(str : string; Length : natural; FillChar : character := ' ') return string;
--  function str_toLower(str : string)                        return string;
--  function str_toUpper(str : string)                        return string;
end package;

package body string_operations is
  function str_replace(
    str : string;
    pattern : string;
    replace : string;
    max_num_of_replacements : in natural := natural'high
  ) return string is
  begin
    return "not implemented";
  end;

end package body string_operations;
