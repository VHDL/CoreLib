package corelib_Dict is
  -- Removing generics for now to enable simple example under tested under
  -- Travis with GHDL
  --generic (
  --  type KEY_TYPE;
  --  type VALUE_TYPE;
  --  function to_hash(d : in KEY_TYPE) return string
  --);

  type PT_DICT is protected
    -- Start with some basic methods
    procedure Set (constant key : in string; constant data : in integer);
    impure function Get (constant key : string) return integer;

    --procedure Get (constant key : in string; data : out integer);
    --procedure Del (constant key : in string);
    --procedure Init (constant logging : in boolean := false);
    --procedure Clear;
    --impure function HasKey (constant key : string) return boolean;
    --impure function Size return natural;
  end protected PT_DICT;
end package corelib_Dict;

package body corelib_Dict is
  type PT_DICT is protected body
    type dictionary_item_t is record
      valid : boolean;
      value : integer;
    end record dictionary_item_t;
    type dictionary_t is array (natural range <>) of dictionary_item_t;

    variable dictionary : dictionary_t(0 to 99) := (others => (false, 0));

    impure function hash (
      key : string)
      return positive is
    begin
      return key'length mod dictionary'length;
    end function hash;

    procedure Set (constant key : in string; constant data : in integer) is
    begin
      assert not dictionary(hash(key)).valid report "Dictionary full";
      dictionary(hash(key)).valid := true;
      dictionary(hash(key)).value := data;
    end;

    impure function Get (constant key : string) return integer is
    begin
      assert dictionary(hash(key)).valid report "Key error";
      return dictionary(hash(key)).value;
    end;

  end protected body PT_DICT;
end package body corelib_Dict;
