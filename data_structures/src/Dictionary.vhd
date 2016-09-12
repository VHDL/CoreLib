package corelib_Dict is


  generic (
    type     KEY_TYPE;
    type     VALUE_TYPE;
    function to_hash(d : in KEY_TYPE, size : positive) return natural;
  );


  type PT_DICT is protected

    procedure Set (constant key : in KEY_TYPE; constant data : in VALUE_TYPE);
    procedure Get (constant key : in KEY_TYPE; data : out VALUE_TYPE);
    impure function Get (constant key : KEY_TYPE) return VALUE_TYPE;
    procedure Del (constant key : in KEY_TYPE);
    procedure Init (constant logging : in boolean := false, constant Size : in natural := 128);
    procedure Clear;
    impure function HasKey (constant key : KEY_TYPE) return boolean;
    impure function Size return natural;

  end protected PT_DICT;

  procedure Merge(d0 : inout PT_DICT; d1 : inout PT_DICT; dout : inout PT_DICT);


end package corelib_Dict;



package body corelib_Dict is


  type t_key_ptr  is access KEY_TYPE;
  type t_data_ptr is access VALUE_TYPE;


  type PT_DICT is protected body

    type t_entry;
    type t_entry_ptr is access t_entry;

    type t_entry is record
      key        : t_key_ptr;
      data       : t_data_ptr;
      last_entry : t_entry_ptr;
      next_entry : t_entry_ptr;
    end record t_entry;


    -- Private method to find entry stored in dictionary
    impure function Find (constant key : KEY_TYPE) return t_entry_ptr;

    impure function Find (constant key : KEY_TYPE) return t_entry_ptr is
    begin
    end function Find;


    procedure Set (constant key : in KEY_TYPE; constant data : in VALUE_TYPE) is
    begin
    end procedure Set;

    procedure Get (constant key : in KEY_TYPE; data : out VALUE_TYPE) is
    begin
    end procedure Get;

    impure function Get (constant key : KEY_TYPE) return VALUE_TYPE is
    begin
    end function Get;

    procedure Del (constant key : in KEY_TYPE) is
    begin
    end procedure Del;

    procedure Init (constant logging : in boolean := false, constant Size : in natural := 128) is
    begin
    end procedure Init;

    procedure Clear  is
    begin
    end procedure Clear;

    impure function HasKey (constant key : KEY_TYPE) return boolean is
    begin
    end function HasKey;

    impure function Size return natural is
    begin
    end function Size;


  end protected body PT_DICT;


  procedure Merge(d0 : inout PT_DICT; d1 : inout PT_DICT; dout : inout PT_DICT) is
  begin
  end procedure Merge;


end package body corelib_Dict;
