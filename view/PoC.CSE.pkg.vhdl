-- Package author:    Patrick Lehmann - Patrick.Lehmann@tu-dresden.de
-- =============================================================================
-- Interface name:    PoC.CSE (Command-Status-Error Interface)
-- Developed by:      Patrick Lehmann
-- Standard/Manual:   http://poc-library.readthedocs.io/en/release/Interfaces/CommandStatusError.html
-- =============================================================================
-- 
-- Description:
-- -------------
-- PoC.CSE is designated to couple a stack of protocol layers. An upper layer
-- provides a command. The lower layer returns a status signal. If status is
-- ERROR, than the error signal is valid. It can than be used for further
-- debugging, reporting or detailed error handling. E.g. to distinguish between
-- fatal and recoverable errors.
-- 
-- Rules:
-- * All types are enumerated types
-- * Command contains at least: COMMAND_UNKNWON
-- * Status contains at least: STATUS_ERROR
-- * Error contains at least: ERROR_NONE
--
package PoC_CSE is
	generic (
		type CommandType is ( <> );
		type StatusType is ( <> );
		type ErrorType is ( <> )
	);

	type R_CSE is record
		Command : CommandType;
		Status  : StatusType;
		Error   : ErrorType;
	end record;

	view V_CSE of R_CSE is
		Command : in;
		Status  : out;
		Error   : out;
	end view;
end package;
