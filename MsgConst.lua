
--[[

 @Author shan 
 @Date:

]]


--[[ --
	store the server info
]]
ServerInfo = {
	SERVER_IP = "http://192.168.1.198",
	SERVER_URL = "http://192.168.1.198/games/kezhan/index.php",

}


--[[ ======================================MESSAGE=======================================================]]
--[[--
	message head
]]
MSG_HEAD = {
			Name = "kezhan",		-- game name
			Build = "91",			-- platform
			SNAME = "",				-- ServerNAME
			Ver = "100",			-- version
			PID = "",				-- player id default is nil
			DID = ""				-- device id // mac address
}

--[[--
	Request ID
]]

REQUEST_ID = {
        -- Login 
		LOGIN_GET_SERVER_LIST_DATA = 'serverList';     --get server json data
		LOGIN_GET_PLAYER_INFO = 'gpinfo';     --get player datas when choose server
		LOGIN_INIT_PLAYER_INFO = 'InitPInfo';     --init player information
		LOGIN_GET_SERVER_PID = 'GSP';     -- the player want get pid for first play
		LOGIN_REGISTER_USER_INFO = 'REGU';     -- update name,pwd,email
		LOGIN_GET_REGISTER_INFO = 'GREG';     -- get email , by name

    	-- msg
    	MSG_SEND_MSG = 'SMsg'; -- send message to other player
    	MSG_RECV_MSG = 'RMsg'; -- recv message from server that other player sent to me
    	MSG_UPDATE_MSG = 'UDMsg'; -- update state, remove or clear attachment
    	MSG_SYS_CLIENT_TO_SERVER = 'sysrecv';
    	MSG_SYS_SERVER_TO_CLIENT = 'syssend';

    	-- recruit
	    RECRUIT_DOWNLOAD = 'recrdown';
	    RECRUIT_UPDATE = 'recrupdate';

	    -- heros
	    HERO_UPLOAD = 'heroupload';

	    -- formation
	    FORM_UPLOAD = 'formupload';
}


KEY_CONST = {
		MSG_BODY = 'Body';
		ARRAY_COUNT = 'count';
	    -- base info
	    SERVER_ID = 'SID';    -- server id
	    PLAYER_ID = 'PID';    -- player id
	    UID = 'UID';
	    DEVICE_ID = 'DID';    -- device id
	    SERVER_NAME = 'SNAME';-- server name like 91_1
	    THIRD_ID  = 'TID';    -- Third id
	    NAME = 'Name';
	    NICKNAME = 'NickName';
	    PWD = 'Pwd';
	    EMAIL = 'email';
	    
	    --base user key
	    BASE_INFO_LEVEL = 'LV';
	    BASE_INFO_EXP = 'Exp';
	    BASE_INFO_SILVER = 'Silver';
	    BASE_INFO_GOLD = 'Gold';
	    BASE_INFO_GOLD_BUY = 'GoldBuy';
	    BASE_INFO_ENERGY = 'Engy'; -- energy

	    --formation
	    FORMATIONS = 'form';
	    FORM_USING_ID = 'id';



	    -- recruit
	    RECRUIT_INFO_KEY = 'recruit';
		RECRUIT_ID          = 'id';
		RECRUIT_CD_DURATION = 'rcdd';
		RECRUIT_UPDATE_TIME = 'rut';
		RECRUIT_TIMES = 'rtime';
		RECRUIT_IS_IN_CD = 'iscd' ;

}