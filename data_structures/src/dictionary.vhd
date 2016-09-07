package corelib_Dict is
  -- Removing generics for now to enable simple example tested under
  -- Travis with GHDL
  --generic (
  --  type KEY_TYPE;
  --  type VALUE_TYPE;
  --  function to_hash(d : in KEY_TYPE) return string
  --);
  constant dictionary_size_c : positive := 100;
  type T_DICT_ITEM is record
    valid : boolean;
    data : integer;
  end record T_DICT_ITEM;
  type T_DICT is array (0 to dictionary_size_c - 1) of T_DICT_ITEM;

  function Get (dict : T_DICT; key  : string) return integer;

  type PT_DICT is protected
    -- Start with some basic methods
    procedure Set (key : string; data : integer);
    impure function Get (key : string) return integer;
    impure function Export return T_DICT;

    --procedure Get (constant key : in string; data : out integer);
    --procedure Del (constant key : in string);
    --procedure Init (constant logging : in boolean := false);
    --procedure Clear;
    --impure function HasKey (constant key : string) return boolean;
    --impure function Size return natural;
  end protected PT_DICT;
end package corelib_Dict;

package body corelib_Dict is
  function hash (dict : T_DICT; key : string) return positive is
  begin
    return key'length mod dict'length;
  end function hash;

  function Get (dict : T_DICT; key  : string) return integer is
  begin
    assert dict(hash(dict, key)).valid report "Key error";
    return dict(hash(dict, key)).data;
  end;

  type PT_DICT is protected body
    variable dictionary : T_DICT := (others => (false, 0));

    procedure Set (key : string; data : integer) is
    begin
      assert not dictionary(hash(dictionary, key)).valid report "Dictionary full";
      dictionary(hash(dictionary, key)).valid := true;
      dictionary(hash(dictionary, key)).data := data;
    end;

    impure function Get (key : string) return integer is
    begin
      return Get(dictionary, key);
    end;

    impure function Export return T_DICT is
      variable ret_val : T_DICT;
    begin
      for i in dictionary'range loop
        ret_val(i).valid := dictionary(i).valid;
        ret_val(i).data := dictionary(i).data;
      end loop;
      return ret_val;
    end;

  end protected body PT_DICT;
end package body corelib_Dict;
